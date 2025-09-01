
Netlify Setup — At Your Service (Webhooks + Hosting)

Repo layout:
/netlify.toml
/netlify/functions/_shared_admin.js
/netlify/functions/payfast.js
/netlify/functions/ozow.js
/netlify/functions/yoco.js
/netlify/functions/snapscan.js
/web_build/                  # optional: Flutter web export here
/firestore.rules
/firestore.indexes.json
/seed_service_data.json
/seed_import.js               # local-only (optional)
/set_admin_claim.js           # local-only (optional)

1) Push this folder to GitHub (new repo).

2) In Netlify → New site from Git → choose your repo.

3) Environment variables (Site settings → Build & deploy → Environment):
   - SERVICE_ACCOUNT_BASE64 = base64 of your Firebase service account JSON
       macOS: base64 -i serviceAccountKey.json | pbcopy
   - PAYFAST_PASSPHRASE = (if using PayFast passphrase)
   - OZOW_SECRET = your Ozow secret
   - YOCO_WEBHOOK_SECRET = your Yoco webhook secret
   - SNAPSCAN_SECRET = your SnapScan secret

4) Deploy site. Your function URLs will be:
   https://<site>.netlify.app/.netlify/functions/payfast
   https://<site>.netlify.app/.netlify/functions/ozow
   https://<site>.netlify.app/.netlify/functions/yoco
   https://<site>.netlify.app/.netlify/functions/snapscan

5) Set these as webhook/notify URLs in each gateway dashboard.

Security: Implement the signature/HMAC verification marked as TODOs inside each function before going live.
