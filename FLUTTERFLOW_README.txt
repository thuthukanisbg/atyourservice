
FlutterFlow Wiring — Minimum Viable Flow

1) Settings → Firebase → connect your Firebase project.
2) Firestore → Collections: create per Codex (users, providers, serviceCategories, services, requests, chats/messages, reviews, payments, payouts, promoCodes, tickets).
3) Auth pages: AuthGateway, Register, Login; write a users doc with role 'client' on first signup.
4) Role Router: if users.role == 'provider' → Provider stack; if 'admin' → show Admin menu; else → Client stack.
5) Client flow: Home → Category → Service → RequestNew (write /requests).
6) Provider flow: ProOnboard (write /providers/{uid}) → ProHome (offers) → ProJobDetail (Accept/Start/Complete).
7) Payments: open hosted checkout (PayFast/Ozow/Yoco/SnapScan) passing requestId as reference/metadata.
8) Webhooks: Netlify functions update /payments and /requests/<id>.payment.status = 'paid' on success.
