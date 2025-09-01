
Firebase Setup — Quick Steps

1) Console:
   - Create project
   - Firestore (Native) → create
   - Rules → paste firestore.rules → Publish
   - Indexes → add composites, or use CLI
   - Auth → enable Email/Password + Google
   - Storage → enable bucket

2) CLI (optional):
   npm i -g firebase-tools
   firebase login
   firebase use <YOUR_PROJECT_ID>
   firebase deploy --only firestore:rules
   firebase firestore:indexes:update firestore.indexes.json

3) Seed data (choose ONE):
   - No-code: build Admin Seed Page in FlutterFlow (see Codex Section 18)
   - Local script: node seed_import.js  (requires serviceAccountKey.json locally)

4) Admin claim:
   - Get your UID (Console → Auth → Users)
   - Local script: node set_admin_claim.js <UID> true
   - Sign out/in (claim takes effect)
