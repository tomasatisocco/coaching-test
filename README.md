# Coaching — GPS test app (Vivir como Coach)

Flutter web + Firebase app for the **GPS** professional-development test.
User signs up → pays via MercadoPago → takes the test → receives a PDF report
by email.

- **Public URL**: https://coaching-test-3c129.web.app
- **Firebase project**: `coaching-test-3c129` (single project)
- **Stack**: Flutter (Dart 2.18+) · `flutter_bloc` · `go_router` · Firebase
  Auth/Firestore/Storage/Hosting/Remote Config · Cloud Functions (TS, Node 18,
  region `southamerica-east1`) · MercadoPago · Nodemailer/Gmail
- **Credentials**: separate Drive handoff folder — see [§ Credentials](#credentials)

---

## Repo layout

```
lib/                          Flutter app (one feature per folder: cubit + view + widgets)
  main_<flavor>.dart            One entrypoint per flavor (development/staging/production)
  firebase_options.dart         FlutterFire-generated config
  app/view/app.dart             Root widget + GoRouter + redirect by user Status
packages/                     Local path packages — only place that touches each Firebase SDK
  auth_repository/               firebase_auth wrapper
  firestore_repository/          cloud_firestore wrapper
  storage_repository/            firebase_storage wrapper
  data_persistence_repository/   shared_preferences wrapper
  functions_repository/          cloud_functions wrapper
functions/src/index.ts        All Cloud Functions live here (~700 lines, single file)
firestore.rules               ⚠️ Currently allow-all — see § Security
```

---

## Prerequisites

- Flutter SDK 3.10+ · Node **18.x** · Firebase CLI · FlutterFire CLI
- Xcode / Android Studio only if you'll run on a device (web works without)

```sh
flutter doctor
node --version    # must be 18.x
```

---

## First-time setup

```sh
git clone https://github.com/tomasatisocco/coaching-test.git
cd coaching-test

./refresh_dependencies.sh         # parallel `pub get` across root + each package
cd functions && npm install && cd ..

firebase login
firebase use coaching-test-3c129  # already pinned in .firebaserc
```

Then drop the credentials from the Drive handoff folder into place (see
[§ Credentials](#credentials) below).

---

## Running the app

Three flavors, each with its own entrypoint. **Always pass both `--flavor` and
`--target`:**

```sh
flutter run -d chrome --flavor development --target lib/main_development.dart
flutter run -d chrome --flavor staging     --target lib/main_staging.dart
flutter run -d chrome --flavor production  --target lib/main_production.dart
```

---

## The "three flavors" model (read this once)

> 🚩 There is exactly **one** Firebase project. The three "environments" are
> **not** separate Firebase projects — they're sibling document trees inside
> Firestore under `environments/{development|staging|production}/...`.

- `FirestoreRepository.development() / .staging() / .production()` picks which
  root document the app reads/writes. `StorageRepository` mirrors the pattern.
- Each `main_<flavor>.dart` wires the correct factory.
- Cloud Functions fan out the same way: three near-identical Firestore
  triggers (`readDevTests` / `readStageTests` / `readProdTests`). **When you
  add a Firestore-triggered function, mirror it across all three paths.**

Subcollections (see `CollectionKeys` in
`packages/firestore_repository/lib/src/firestore_repository.dart`):
`coaching_tests`, `users`, `admin_users`, `mp/{intents,preference_templates,authorization}`.

---

## User state machine & routing

`Status` enum in `lib/welcome/models/user_date_model.dart`:
`registered → infoCompleted → testPaid → testStarted → testCompleted →
resultsSending → resultsSent`. Persisted in Firestore as the enum **index**
and cached locally so the router redirect callback can decide synchronously.

Routing is `go_router` with a redirect in `lib/app/view/app.dart` that maps
`Status` to a route. **Add a screen?** Decide whether `Status` should route
to it; if yes, extend the enum + the redirect switch.

Three routes bypass the redirect: `/mercadopago` (MP OAuth callback),
`/admin_login`, and any URL containing `success=true`.

---

## Cloud Functions

Single file: `functions/src/index.ts`. Exports:

| Function           | Trigger                                      | What it does                                          |
| ------------------ | -------------------------------------------- | ----------------------------------------------------- |
| `readDevTests` / `readStageTests` / `readProdTests` | onCreate `environments/{env}/coaching_tests/{testId}` | Builds PDF, emails it, advances user `Status` |
| `reSendEmail`      | `https.onCall`                               | Rebuild & re-send a PDF for a given `testId`          |
| `mercadoPagoOAuth` | `https.onCall` (secrets: `MP_CLIENT_ID`, `MP_CLIENT_SECRET`) | Marketplace OAuth handshake |
| `createCheckout`   | `https.onCall` (secret: `MP_ACCESS_TOKEN`)   | Creates MP checkout preference                        |

Commands (from `functions/`):

```sh
npm run build        # tsc
npm run lint         # eslint — also a predeploy hook
npm run serve        # build + emulators:start --only functions
npm run deploy       # firebase deploy --only functions
```

Local `.env` (Nodemailer) and Firebase function secrets (MercadoPago) are
documented in the Drive handoff folder.

---

## Testing

```sh
flutter test --coverage --test-randomize-ordering-seed random
flutter test test/path/to/file_test.dart
flutter test --name "substring"

# Each package also has its own suite — run from its directory.
cd packages/firestore_repository && flutter test
```

Mocks: `mocktail`. Cubit/bloc assertions: `bloc_test`. Standard widget-test
harness: `test/helpers/pump_app.dart`.

---

## Lint & conventions

- `very_good_analysis` everywhere. Root disables `public_member_api_docs`;
  **packages under `packages/*` still enforce it** — public symbols need `///`.
- Treat lint warnings as failures.
- Cloud Functions use Google ESLint config; `npm run lint` is a predeploy hook
  (deploys fail on lint errors).
- Feature folders: `cubit/ + view/ + widgets/ (+ models/)`. Each page exposes a
  `static const name` used as the `GoRoute.name`.
- Localization: `lib/l10n/arb/app_es.arb` is the source-of-truth (Spanish);
  `app_en.arb` is the translation. Codegen runs on `flutter run/build`.

---

## Security

`firestore.rules` is currently **`allow read, write: if true`** for every
document. The app relies on client-side gating. **Tighten the rules in the
same PR if you add access patterns touching privileged data** (payment
records, admin users, OAuth tokens). `storage.rules` is deny-all.

---

## Deploy

```sh
# Web (the public site)
flutter build web --release --flavor production --target lib/main_production.dart
firebase deploy --only hosting

# Functions only
cd functions && npm run deploy

# Everything (hosting + functions + rules + remoteconfig)
firebase deploy
```

Verify: register a user, complete the test, confirm `Status` transitions in
Firestore and the PDF email arrives. Check `firebase functions:log` if not.

---

## Credentials

All secrets (Firebase config files, MercadoPago credentials, Gmail SMTP) live
in a separate **Drive handoff folder** — they are **not** committed to this
repo. Ask the project owner for access.

To request invites for Firebase Console, MercadoPago developer dashboard, and
this GitHub repo, email **tomastisocco97@gmail.com**.

---

## License

Proprietary. © Vivir como Coach.
