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
- GitHub Actions and Fastlane

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

GitHub Actions handles code checks and Android APK distribution through Fastlane and Firebase App Distribution.

| Workflow | Trigger | Actions | Distribution |
| --- | --- | --- | --- |
| Development CI | Pull requests from any branch targeting `development` | Install dependencies, analyze code, and run tests | — |
| Development Firebase Distribution | Manual run on `development` | Analyze code, run tests, build a signed release APK, and upload it to Firebase | `team` group |
| Main Firebase Distribution | Merge a pull request from `development` into `main` within the same repository | Analyze code, run tests, build a signed release APK, and upload it to Firebase | `client` group |

Signing credentials and the Firebase service account key are stored in GitHub Actions Secrets. Temporary credential files are removed after each distribution run.

The current distribution workflows build Android APKs. iOS distribution is not yet configured.

## Platforms

- Android
- iOS

## Development

Developed by **Eyad Waleed**  
© 2026 Fame X. All rights reserved.
