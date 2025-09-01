/**
 * Netlify Function — PayFast webhook (skeleton)
 * Env: PAYFAST_PASSPHRASE (if used), SERVICE_ACCOUNT_BASE64
 * Docs: https://developers.payfast.co.za/docs
 */
const { markPaymentResult } = require("./_shared_admin");

exports.handler = async function (event, context) {
  try {
    if (event.httpMethod !== "POST") {
      return { statusCode: 405, body: "Method Not Allowed" };
    }

    const contentType = event.headers["content-type"] || "";
    let payload = {};
    if (contentType.includes("application/json")) {
      payload = JSON.parse(event.body || "{}");
    } else {
      // parse x-www-form-urlencoded
      payload = {};
      (event.body || "").split("&").forEach(kv => {
        const [k, v] = kv.split("=");
        if (k) payload[decodeURIComponent(k)] = decodeURIComponent((v || "").replace(/\+/g, " "));
      });
    }

    // TODO: Validate signature per PayFast docs (pf_signature + passphrase if set)
    const valid = true; // replace with actual verification
    if (!valid) return { statusCode: 400, body: "Invalid signature" };

    const requestId = payload["custom_str1"] || payload["m_payment_id"] || null;
    const amount = parseFloat(payload["amount_gross"] || payload["amount"] || "0");
    const statusStr = (payload["payment_status"] || "").toLowerCase();
    const status = statusStr === "complete" ? "paid" : "pending";
    const txnId = payload["pf_payment_id"] || payload["token"] || undefined;

    await markPaymentResult({
      requestId,
      gateway: "payfast",
      amountZar: amount,
      status,
      raw: payload,
      txnId,
    });

    return { statusCode: 200, body: "OK" };
  } catch (e) {
    console.error("payfast webhook error:", e);
    return { statusCode: 500, body: "Server error" };
  }
};