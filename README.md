# 🍎 Emoji Lover — A Delightful Educational App for iOS

**Emoji Lover** is a charming and interactive educational app built entirely with **Swift** and **SwiftUI**. It's designed to help children learn vocabulary, numbers, shapes, and colors in a fun, engaging, and aesthetically pleasing environment. The app showcases a modern, scalable, and user-centric approach to iOS development, with a focus on polished UI, smooth animations, and a rewarding user experience.

---

## 🚀 Features

-   🎨 **Dynamic Learning Categories** — A scalable grid layout that includes Fruits, Animals, Numbers, Shapes, and Colors, with the ability to easily add more.
-   🗣️ **Interactive Audio Learning** — Every item is read aloud using Apple's `AVFoundation` framework to provide a rich, auditory learning experience.
-   ⚙️ **Custom Voice Settings** — A dedicated settings screen allows users to select from a curated list of high-quality system voices (including Siri) and adjust the speech rate.
-   ✨ **Polished UI & Animations** — A custom-designed interface with directional slide animations, responsive "grow-on-tap" button feedback, and a dynamic theming system that changes the background color to match each item.
-   🏆 **Rewarding User Flow** — A finite learning loop for each category that concludes with a positive "Category Completed!" screen to motivate and encourage young learners.
-   📱 **Modern & Scalable Architecture** — Built entirely with SwiftUI, demonstrating a strong command of declarative UI, state management, and reusable components.

---

## 📦 Tech Stack

-   **Language**: Swift
-   **UI Framework**: SwiftUI
-   **Apple APIs**: AVFoundation (for `AVSpeechSynthesizer`)
-   **IDE**: Xcode
-   **Design Principles**: MVVM (Model-View-ViewModel)

---

## 📂 Project Structure

A simplified overview of the key files in the Xcode project.

```swift
Emoji Lover/
├── Views/
│   ├── CategoriesView.swift      # The main category grid screen
│   ├── LearningCategoryView.swift # The core learning/flashcard screen
│   ├── SettingsView.swift        # The user-configurable settings screen
│   └── ContentView.swift         # The root view with the TabView
│
├── Models/
│   └── LearningData.swift        # Contains all data models (LearningItem, LearningCategory)
│
├── Helpers/
│   ├── SpeechHelper.swift        # Manages all Text-to-Speech logic
│   └── BackgroundColorModifier.swift # Handles the dynamic background colors
│
├── Styles/
│   ├── GrowButtonStyle.swift     # Defines the "grow on tap" animation
│   └── SpringyButtonStyle.swift  # Defines the "squishy" press animation
│
└── Emoji_LoverApp.swift      # The main entry point for the app
