# Ya Perfume

An app that helps users discover suitable perfumes through guided questions or custom fragrance ratios, with personalized recommendations and perfume details in five languages.

## Features

- Guided perfume discovery through preference-based questions
- Custom percentage selection across six fragrance families
- Up to four matching perfume recommendations
- Detailed perfume profiles
- Multilingual interface with Arabic right-to-left support
- Responsive layouts
- Bundled perfume data for offline discovery

## Perfume Discovery

### Guided Questions

Users answer questions about their preferences, usage time, seasons, occasions, and fragrance families to discover suitable perfumes.

### Fragrance Percentages

Users create a fragrance profile using six families:

- Sweet
- Fresh
- Floral
- Woody
- Fruity
- White Floral / Jasmin

Each percentage ranges from 0 to 100, and the total must equal 100 before submission.

The application ranks perfumes by the sum of the absolute differences across all six families and returns the closest four. Equal scores are ordered alphabetically by perfume name.

Stored percentages are compared directly without normalization. The difference score is a ranking measure, not a match percentage.

## Perfume Details

Recommended perfume profiles include:

- Product code
- Usage time and suitable season
- Style tags and fragrance families
- Suitable occasions
- Fragrance projection

Users can return to their results or start a new discovery journey.

## Supported Languages

- Arabic
- English
- French
- Russian
- Italian

## Data Storage

Perfume data is bundled as local JSON assets:

- `assets/data/ya_perfume_percentages.json`
- `assets/data/ya_perfume_questions.json`

The percentage discovery flow combines fragrance percentages with details from the questions dataset.

Records are currently matched by perfume name. Code-based matching is planned once consistent codes are available in both datasets.

## Tech Stack

- Flutter and Dart
- Bloc / Cubit
- GetIt
- Easy Localization
- Flutter ScreenUtil
- Flutter SVG
- Firebase Core
- Local JSON assets
- GitHub Actions
- Fastlane
- Firebase App Distribution
- Google Play Developer API

## Architecture

The application follows a feature-based Clean Architecture:

- **Data:** Asset loading, models, and repository implementations
- **Domain:** Entities, repository contracts, and matching use cases
- **Presentation:** Screens, widgets, and Cubit state management

The results feature displays prepared results supplied by the discovery flows. Shared helpers, styling, and translation utilities are located in the core layer.

## Testing

Unit tests cover percentage validation, matching calculations, model parsing, asset loading, repositories, recommendation ranking, and Cubit behavior.

Integration tests cover the complete user journey, from choosing a discovery method and entering preferences to viewing recommendations, opening perfume details, and starting a new journey.

## CI/CD

GitHub Actions handles code checks, Firebase APK distribution, and Google Play production uploads through Fastlane.

| Workflow | Trigger | Actions | Destination |
| --- | --- | --- | --- |
| Development CI | Pull requests from any branch targeting `development` | Install dependencies, analyze code, and run tests | — |
| Development Firebase Distribution | Manual run on `development` | Analyze code, run tests, build a signed release APK, and upload it to Firebase | Firebase `team` group |
| Main Firebase Distribution | Merge a pull request from `development` into `main` within the same repository | Analyze code, run tests, build a signed release APK, and upload it to Firebase | Firebase `client` group |
| Google Play Production | Merge a pull request from `main` into `google-play-production` within the same repository | Analyze code, run tests, build a signed release AAB, and upload it to Google Play | Google Play production track |

### Google Play Production

The production workflow is defined in:

` .github/workflows/google-play-production.yml `

It runs only after a pull request from `main` into `google-play-production` is merged. Opening a pull request or closing it without merging does not start production deployment.

The workflow checks out the merged commit and uses:

- Flutter `3.47.7`
- Java `17`
- Ruby `3.3`
- Fastlane lane: `google_play_distribution`
- Android application ID: `com.famex.yaperfume`

The generated Android App Bundle is located at:

`build/app/outputs/bundle/release/app-release.aab`

Fastlane uploads the bundle to the production track with `release_status: "completed"`. Availability to users remains subject to Google Play review and publishing settings.

Each upload must use a version code greater than any previously uploaded version code for the application. Flutter reads this value from the number after `+` in the `pubspec.yaml` version field.

### GitHub Actions Secrets

| Secret | Purpose |
| --- | --- |
| `ANDROID_KEYSTORE_BASE64` | Base64-encoded Android upload keystore |
| `ANDROID_KEYSTORE_PASSWORD` | Keystore password |
| `ANDROID_KEY_ALIAS` | Signing key alias |
| `ANDROID_KEY_PASSWORD` | Signing key password |
| `FIREBASE_ANDROID_APP_ID` | Firebase Android application ID |
| `FIREBASE_SERVICE_ACCOUNT_JSON` | Service account credentials for Firebase distribution |
| `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON` | Service account credentials with production release access to Ya Perfume in Google Play Console |

Signing credentials and service account keys are stored in GitHub Actions Secrets. Temporary credential files are removed by cleanup steps that run even if deployment fails.

Firebase distribution workflows build Android APKs. The Google Play production workflow builds an Android App Bundle.

iOS distribution is not yet configured.

## Platforms

- Android
- iOS

## Development

Developed by **Eyad Waleed**  
© 2026 Fame X. All rights reserved.
