/**
 * Netlify Function — SnapScan webhook (skeleton)
 * Env: SNAPSCAN_SECRET, SERVICE_ACCOUNT_BASE64
 * Docs: https://docs.snapscan.co.za/
 */
const { markPaymentResult } = require("./_shared_admin");

exports.handler = async function (event, context) {
  try {
    if (event.httpMethod !== "POST") {
      return { statusCode: 405, body: "Method Not Allowed" };
    }

    // TODO: verify signature using SNAPSCAN_SECRET
    const valid = true;
    if (!valid) return { statusCode: 400, body: "Invalid signature" };

    const payload = JSON.parse(event.body || "{}");
    const requestId = payload?.invoice?.reference || payload?.reference || null;
    const amount = parseFloat(payload?.amount || 0) / 100;
    const txnId = payload?.id || payload?.invoice?.id || undefined;
    const successful = (payload?.status || "").toLowerCase() === "paid";

    await markPaymentResult({
      requestId,
      gateway: "snapscan",
      amountZar: amount,
      status: successful ? "paid" : "pending",
      raw: payload,
      txnId,
    });

    return { statusCode: 200, body: "OK" };
  } catch (e) {
    console.error("snapscan webhook error:", e);
    return { statusCode: 500, body: "Server error" };
  }
};