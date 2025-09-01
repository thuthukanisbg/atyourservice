/**
 * Netlify Function — Ozow webhook (skeleton)
 * Env: OZOW_SECRET, SERVICE_ACCOUNT_BASE64
 * Docs: https://ozow.com
 */
const { markPaymentResult } = require("./_shared_admin");

exports.handler = async function (event, context) {
  try {
    if (event.httpMethod !== "POST") {
      return { statusCode: 405, body: "Method Not Allowed" };
    }

    let payload = {};
    const contentType = event.headers["content-type"] || "";
    if (contentType.includes("application/json")) {
      payload = JSON.parse(event.body || "{}");
    } else {
      payload = {};
      (event.body || "").split("&").forEach(kv => {
        const [k, v] = kv.split("=");
        if (k) payload[decodeURIComponent(k)] = decodeURIComponent((v || "").replace(/\+/g, " "));
      });
    }

    // TODO: validate Ozow checksum/hash with OZOW_SECRET
    const valid = true;
    if (!valid) return { statusCode: 400, body: "Invalid signature" };

    const requestId = payload["SiteReference"] || payload["TransactionReference"] || null;
    const amount = parseFloat(payload["Amount"] || "0");
    const successful = (payload["Status"] || "").toLowerCase() === "completed";
    const txnId = payload["TransactionId"] || undefined;

    await markPaymentResult({
      requestId,
      gateway: "ozow",
      amountZar: amount,
      status: successful ? "paid" : "pending",
      raw: payload,
      txnId,
    });

    return { statusCode: 200, body: "OK" };
  } catch (e) {
    console.error("ozow webhook error:", e);
    return { statusCode: 500, body: "Server error" };
  }
};