/**
 * Shared Firestore Admin init for Netlify Functions
 * - Provide service account via env:
 *   - SERVICE_ACCOUNT_BASE64 (base64-encoded JSON), or
 *   - GOOGLE_APPLICATION_CREDENTIALS_JSON (raw JSON string)
 */
const admin = require("firebase-admin");

let app;
function initAdmin() {
  if (app) return admin;
  const keyJson =
    process.env.GOOGLE_APPLICATION_CREDENTIALS_JSON ||
    (process.env.SERVICE_ACCOUNT_BASE64
      ? Buffer.from(process.env.SERVICE_ACCOUNT_BASE64, "base64").toString("utf8")
      : null);

  if (!keyJson) {
    throw new Error("Missing Firebase service account (set GOOGLE_APPLICATION_CREDENTIALS_JSON or SERVICE_ACCOUNT_BASE64).");
  }

  const creds = JSON.parse(keyJson);
  app = admin.initializeApp({
    credential: admin.credential.cert(creds),
  });
  return admin;
}

async function markPaymentResult({ requestId, gateway, amountZar, status, raw, txnId }) {
  const admin = initAdmin();
  const db = admin.firestore();
  const id = txnId || `${gateway}_${Date.now()}`;
  const payDoc = db.collection("payments").doc(id);
  await payDoc.set(
    {
      requestId: requestId || null,
      gateway,
      amountZar: typeof amountZar === "number" ? amountZar : 0,
      status, // 'paid' | 'pending' | 'failed' | 'refunded'
      raw,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    },
    { merge: true }
  );

  if (status === "paid" && requestId) {
    await db.collection("requests").doc(requestId).set(
      {
        payment: {
          method: gateway,
          status: "paid",
          gateway,
          txnId: id,
        },
      },
      { merge: true }
    );
  }
  return id;
}

module.exports = { initAdmin, markPaymentResult };