/**
 * Netlify Function — Yoco webhook (skeleton)
 * Env: YOCO_WEBHOOK_SECRET, SERVICE_ACCOUNT_BASE64
 * Docs: https://developer.yoco.com/
 */
const { markPaymentResult } = require("./_shared_admin");

exports.handler = async function (event, context) {
  try {
    if (event.httpMethod !== "POST") {
      return { statusCode: 405, body: "Method Not Allowed" };
    }

    // TODO: verify HMAC using YOCO_WEBHOOK_SECRET over raw body (event.body)
    const valid = true;
    if (!valid) return { statusCode: 400, body: "Invalid signature" };

    const payload = JSON.parse(event.body || "{}");
    const evt = payload;
    const data = evt?.data || {};
    const requestId = data?.metadata?.requestId || null;
    const amount = (data?.amount || 0) / 100;
    const txnId = data?.id || evt?.id || undefined;
    const successful = (data?.status || evt?.type || "").toString().includes("succeeded");

    await markPaymentResult({
      requestId,
      gateway: "yoco",
      amountZar: amount,
      status: successful ? "paid" : "pending",
      raw: payload,
      txnId,
    });

    return { statusCode: 200, body: "OK" };
  } catch (e) {
    console.error("yoco webhook error:", e);
    return { statusCode: 500, body: "Server error" };
  }
};