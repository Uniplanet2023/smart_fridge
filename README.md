# Smart Fridge App

## Overview

The Smart Fridge app is designed to reduce food waste using AI. It helps users manage their food inventory by sending reminders about approaching expiration dates, suggesting recipes based on available ingredients, and scanning receipts to automatically add items to the app.

The app is built following the principles of Clean Architecture to ensure scalability, testability, and maintainability.

## Project Structure

This project follows Clean Architecture principles, dividing the codebase into distinct layers:
lib/
|-- config/
|-- core/
| |-- shared models/
| |-- shared entities/
| |-- prompts/
|-- features/
| |-- feature_name/
| | |-- data/
| | |-- domain/
| | |-- presentation/
|-- main.dart

- **Core**: Contains shared components and utilities.
- **Config**: Contains Theme, styling, shared pages and widgets.
- **Features**: Contains all the feature-specific folders, each following the Clean Architecture pattern.
  - **Data Layer**: Repositories, data sources, and models.
  - **Domain Layer**: Use cases, entities, and repository interfaces.
  - **Presentation Layer**: UI components, state management, and view models.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following tools installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) version 3.x.x
- [Dart](https://dart.dev/get-dart) version 2.x.x
- A code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)
- [Xcode](https://developer.apple.com/xcode/) (for iOS development)
- [Android SDK](https://developer.android.com/studio) (for Android development)

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/smart-fridge.git
   ```

2. **Install Dependencies:**

Fetch the project dependencies by running:

    ```bash
    flutter pub get
    ```

3. **Configure the Environment:**

Create a `.env` file in the root of the project and add your environment-specific variables, such as API keys.

Example `.env` file:

    ```bash
        API_KEY=your_api_key_here
    ```
4. **Assets:**

    Ensure that the assets are correctly referenced in your pubspec.yaml file. Assets include images, animations, and other resources.

