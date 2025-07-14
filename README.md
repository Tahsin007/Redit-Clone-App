# Reddit Clone

A feature-rich Reddit clone built with Flutter and Firebase, demonstrating a modern, scalable, and maintainable mobile application architecture.

## 📖 Table of Contents

- [✨ Features](#-features)
- [📂 Folder Structure](#-folder-structure)
- [📦 Dependencies](#-dependencies)
- [🏗️ Architecture](#️-architecture)
- [🚀 Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [📸 Screenshots](#-screenshots)

## ✨ Features

- **Authentication:** Secure user authentication using Firebase Authentication with Google Sign-In.
- **Community:** Create and join communities, view community posts, and manage your communities.
- **Posts:** Create and view posts with titles, descriptions, and images.
- **Home Feed:** A personalized home feed with posts from your joined communities.
- **Error Handling:** Graceful error handling and user feedback with snackbars.
- **Scalable Architecture:** A clean and scalable architecture using the Riverpod state management library.

## 📂 Folder Structure

The project follows a feature-first folder structure, with a clear separation of concerns.

```
lib/
├── core/
│   ├── common/
│   ├── constants/
│   ├── models/
│   ├── providers/
│   ├── router/
│   ├── theme/
│   └── utils/
├── features/
│   ├── Auth/
│   │   ├── repository/
│   │   ├── view/
│   │   └── view_model/
│   ├── Community/
│   └── Home/
├── firebase_options.dart
└── main.dart
```

- **`core`**: Contains the core components of the application, such as routing, theme, models, and providers.
- **`features`**: Contains the different features of the application, such as authentication, community, and home.
- **`main.dart`**: The entry point of the application.

## 📦 Dependencies

The project uses the following dependencies:

- **`flutter`**: The core Flutter framework.
- **`cupertino_icons`**: iOS-style icons.
- **`google_fonts`**: A collection of Google Fonts.
- **`firebase_core`**: The core Firebase package.
- **`firebase_storage`**: Firebase Storage for file storage.
- **`firebase_cloud_firestore`**: Cloud Firestore for NoSQL database.
- **`flutter_riverpod`**: A state management library for Flutter.
- **`google_sign_in`**: Google Sign-In for authentication.
- **`firebase_auth`**: Firebase Authentication for user authentication.
- **`fpdart`**: A functional programming library for Dart.
- **`go_router`**: A declarative routing package for Flutter.

## 🏗️ Architecture

The project follows a clean and scalable architecture using the **Riverpod** state management library. The architecture is divided into three main layers:

- **View**: The UI layer of the application, which is responsible for displaying the data to the user.
- **View Model**: The layer that contains the business logic of the application and communicates with the repository.
- **Repository**: The layer that is responsible for fetching and storing data from the data source (Firebase).

This architecture allows for a clear separation of concerns, making the code more maintainable and scalable.

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- Flutter SDK: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- Firebase CLI: [https://firebase.google.com/docs/cli](https://firebase.google.com/docs/cli)

### Installation

1. **Clone the repo**
   ```sh
   git clone https://github.com/your_username/redit_clone.git
   ```
2. **Install packages**
   ```sh
   flutter pub get
   ```
3. **Configure Firebase**
   - Create a new Firebase project at [https://console.firebase.google.com/](https://console.firebase.google.com/).
   - Add an Android and iOS app to your Firebase project.
   - Download the `google-services.json` and `GoogleService-Info.plist` files and place them in the `android/app` and `ios/Runner` directories, respectively.
4. **Run the app**
   ```sh
   flutter run
   ```

## 📸 Screenshots

*To be added*