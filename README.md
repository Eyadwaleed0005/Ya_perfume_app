# Ya Perfume

An app that helps users find their ideal perfume through guided questions or custom fragrance ratios, offering personalized recommendations and perfume details in five languages.

## Features

- Guided perfume discovery through questions
- Custom fragrance percentage selection
- Recommendations based on six fragrance families
- Display of up to four matching perfumes
- Detailed perfume profiles
- Multilingual interface and perfume details
- Arabic right-to-left support
- Responsive layouts for different screen sizes
- Bundled perfume data for offline use

## Perfume Discovery

Users can choose between two discovery methods:

### Guided Questions

Answer questions about personal preferences, usage time, seasons, occasions, and preferred fragrance families to discover suitable perfumes.

### Fragrance Percentages

Create a preferred fragrance profile by adjusting six families:

- Sweet
- Fresh
- Floral
- Woody
- Fruity
- White Floral / Jasmin

Each percentage can range from 0 to 100. The total must equal 100 before submitting the selection.

## Percentage Matching

The application compares the selected percentages with each perfume's stored percentages.

For every fragrance family, it calculates the absolute difference between the user's selection and the perfume's value. It then adds the six differences to produce a total difference score.

A lower score means the perfume is closer to the selected fragrance profile.

### Example

| Fragrance Family | User Selection | Perfume Profile | Difference |
| --- | --- | --- | --- |
| Sweet | 20% | 25% | 5 |
| Fresh | 20% | 15% | 5 |
| Floral | 15% | 15% | 0 |
| Woody | 15% | 15% | 0 |
| Fruity | 20% | 20% | 0 |
| White Floral / Jasmin | 10% | 10% | 0 |
| **Total** | **100%** | **100%** | **10** |

Perfumes are ranked by their total difference score, and the closest four are returned. If two perfumes have the same score, they are ordered alphabetically by name.

Stored perfume percentages are compared directly without normalization. The difference score is a ranking measure, not a match percentage.

## Results and Perfume Details

Users can open a recommended perfume to view:

- Product code
- Usage time
- Suitable season
- Style tags
- Preferred fragrance families
- Suitable occasions
- Fragrance projection

Users can return to the results or start a new discovery journey.

Product codes retain their original value. Missing or zero codes are displayed as `YA-0000`.

## Supported Languages

- Arabic
- English
- French
- Russian
- Italian

Interface labels and supported perfume detail values are displayed in the selected language.

## Data Storage

Perfume data is bundled with the application as local JSON assets:

- `assets/data/ya_perfume_percentages.json`
- `assets/data/ya_perfume_questions.json`

The percentage discovery flow loads fragrance percentages and enriches them with perfume details from the questions dataset.

Records are currently matched by perfume name. This temporary matching will be replaced with code-based matching once consistent perfume codes are available in both datasets.

## Tech Stack

- Flutter
- Dart
- Bloc / Cubit
- GetIt
- Easy Localization
- Flutter ScreenUtil
- Flutter SVG
- Local JSON assets
- Clean Architecture

## Architecture

The application follows a feature-based structure with separation between:

- **Data:** JSON loading, models, and repository implementations
- **Domain:** Entities, repository contracts, and matching use cases
- **Presentation:** Screens, widgets, and Cubit state management

The results feature receives prepared perfume result entities from the preceding discovery flow and displays them without performing its own matching or data loading.

Shared helpers, styling, and translation utilities are located in the core layer.

## Testing

The percentage selection feature includes tests for:

- Fragrance percentage totals and validation
- Difference calculations across all six families
- Model parsing
- Local asset loading and detail matching
- Repository behavior
- Recommendation ranking
- Cubit updates and loading behavior

The results feature includes four integration tests covering:

- Displaying the supplied perfumes
- Opening the selected perfume and returning to results
- Product code formatting
- Starting a new journey and clearing previous routes

## CI/CD

CI/CD workflows will be added in a future update.

## Platforms

- Android
- iOS

## Development

Developed by **Eyad Waleed**  
© 2026 Fame X. All rights reserved.
