/**
 * Set custom admin claim for a Firebase Auth user.
 * Usage:
 *   1) npm install firebase-admin
 *   2) node set_admin_claim.js <UID> true
 */
const admin = require('firebase-admin');
const fs = require('fs');

const keyPath = './serviceAccountKey.json';
if (!fs.existsSync(keyPath)) {
  console.error('Missing serviceAccountKey.json (local script).');
  process.exit(1);
}

admin.initializeApp({
  credential: admin.credential.cert(require(keyPath))
});

const uid = process.argv[2];
const isAdmin = (process.argv[3] || 'true') === 'true';

if (!uid) {
  console.error('Usage: node set_admin_claim.js <UID> true|false');
  process.exit(1);
}

(async () => {
  await admin.auth().setCustomUserClaims(uid, { admin: isAdmin });
  console.log(`Custom claim admin=${isAdmin} set for UID: ${uid}`);
  console.log('User must sign out and back in for claim to take effect.');
  process.exit(0);
})();