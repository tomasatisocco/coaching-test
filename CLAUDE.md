# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project shape

- Flutter app (Very Good CLI template) plus a Firebase Cloud Functions backend in TypeScript.
- Flutter code lives in `lib/` and depends on five local path packages under `packages/` (`auth_repository`, `firestore_repository`, `storage_repository`, `data_persistence_repository`, `functions_repository`). Each repository wraps one Firebase SDK and is the only place the rest of the app should touch that SDK.
- Cloud Functions live in `functions/src/index.ts` (single file). They handle PDF generation, email delivery (Nodemailer/Gmail), MercadoPago checkout, and Firestore-triggered side effects.

## Build / run / test commands

The app uses three flavors (development / staging / production), each with its own `main_<flavor>.dart` entrypoint. Always pass both `--flavor` and `--target`:

```sh
flutter run --flavor development --target lib/main_development.dart
flutter run --flavor staging     --target lib/main_staging.dart
flutter run --flavor production  --target lib/main_production.dart
```

Tests (Flutter):

```sh
flutter test --coverage --test-randomize-ordering-seed random
flutter test test/path/to/file_test.dart            # single file
flutter test --name "matches test name substring"   # single test
```

Each package in `packages/*` has its own `flutter test` suite — run it from the package dir.

Localization (codegen runs automatically on `flutter run/build`; ARB files are in `lib/l10n/arb/`, template is `app_es.arb` — Spanish is the source-of-truth locale).

Dependencies across the workspace (root + every local package) can be refreshed in parallel with:

```sh
./refresh_dependencies.sh
```

Cloud Functions (`functions/`):

```sh
cd functions
npm run build           # tsc
npm run lint            # eslint, runs as a Firebase predeploy
npm run serve           # build + firebase emulators (functions only)
npm run deploy          # firebase deploy --only functions
firebase deploy         # everything (hosting, firestore, functions, storage, remoteconfig)
```

Functions need `functions/.env` with `GMAIL_EMAIL` and `GMAIL_PASSWORD` (Nodemailer transport reads these via `dotenv`).

## Environments model

There is **one** Firebase project (`coaching-test-3c129`, see `.firebaserc`). "Environments" are not separate Firebase projects — they are sibling documents under the Firestore `environments` collection:

- `environments/development/...`
- `environments/staging/...`
- `environments/production/...`

`FirestoreRepository.development() / .staging() / .production()` and the matching `StorageRepository` factories pick which document tree they read/write. Each `main_<flavor>.dart` wires the matching factory. Cloud Function triggers also fan out per environment — `index.ts` declares three near-identical listeners on `environments/{env}/coaching_tests/{testId}`. When adding a Firestore-triggered function, mirror it across all three paths.

Subcollections used (see `CollectionKeys` in `packages/firestore_repository/lib/src/firestore_repository.dart`): `coaching_tests`, `users`, `admin_users`, `mp` (with docs `intents` and `preference_templates`).

## App architecture

- State management: BLoC/Cubit via `flutter_bloc`. Repositories are provided once at the root in `lib/app/view/app.dart` via `MultiRepositoryProvider`; per-feature `Cubit`s read them with `context.read<...Repository>()`. `bootstrap.dart` installs an `AppBlocObserver` that logs every state change and error.
- Routing: `go_router`, single `GoRouter` defined in `_AppViewState.router(context)` in `lib/app/view/app.dart`. Navigation is driven by a **redirect callback** that reads the persisted `UserDataModel` from `DataPersistenceRepository` and maps the user's `Status` enum (`registered → /welcome`, `infoCompleted → /payment`, `testPaid|testStarted → /coaching_test`, `testCompleted|resultsSending|resultsSent → /congratulations`, `null → /start`). The MercadoPago return URL (`/mercadopago`), `/admin_login`, and the payment-success callback are explicit exceptions that bypass redirect. When adding a new screen, decide whether the user's `Status` should route to it — if yes, extend both the `Status` enum (`lib/welcome/models/user_date_model.dart`) and the redirect switch.
- The user state machine lives in `Status` (`registered`, `infoCompleted`, `testPaid`, `testStarted`, `testCompleted`, `resultsSending`, `resultsSent`). It is persisted in Firestore (`users/<id>.status` as the enum index) and cached locally via `DataPersistenceRepository`.
- Feature folders under `lib/` follow `cubit/ + view/ + widgets/ (+ models/)`. Each page exposes a `static const name` used as the `GoRoute.name`.

## Linting & conventions

- Root and each package use `very_good_analysis` (root pins to v5 and disables `public_member_api_docs`; the packages still enforce it — public APIs in `packages/*/lib/...` need `///` doc comments). Treat lint warnings as failures.
- Cloud Functions use the Google ESLint config (`functions/.eslintrc`); `npm run lint` runs as a Firebase predeploy hook, so a deploy will fail on lint errors.
- Tests use `mocktail` for mocks and `bloc_test` for cubit/bloc state-flow assertions. `test/helpers/pump_app.dart` is the standard widget-test harness.

## Security rules — do not assume they are tight

`firestore.rules` currently grants `read, write: if true` to all documents. `storage.rules` denies everything. If you're adding access patterns, double-check whether a real rule should land alongside the code change — this repo has historically relied on client-side gating.
