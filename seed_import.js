/**
 * Seed Firestore with serviceCategories and services from seed_service_data.json
 * Usage:
 *   1) npm install firebase-admin
 *   2) Place your service account key at ./serviceAccountKey.json (or set env var for Netlify)
 *   3) node seed_import.js
 */
const fs = require('fs');
const admin = require('firebase-admin');

const keyPath = './serviceAccountKey.json';
if (!fs.existsSync(keyPath)) {
  console.error('Missing serviceAccountKey.json (local seeding). For Netlify, use Admin Seed Page instead.');
  process.exit(1);
}

admin.initializeApp({
  credential: admin.credential.cert(require(keyPath))
});
const db = admin.firestore();

async function upsert(col, id, data) {
  await db.collection(col).doc(id).set(data, { merge: true });
  console.log(`[OK] ${col}/${id}`);
}

(async () => {
  const raw = fs.readFileSync('./seed_service_data.json', 'utf8');
  const seed = JSON.parse(raw);
  for (const cat of seed.serviceCategories) {
    const { id, ...rest } = cat; await upsert('serviceCategories', id, rest);
  }
  for (const svc of seed.services) {
    const { id, ...rest } = svc; await upsert('services', id, rest);
  }
  console.log('Seeding complete.');
  process.exit(0);
})();