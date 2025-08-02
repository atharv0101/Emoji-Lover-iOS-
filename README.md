![Swift](https://img.shields.io/badge/Swift-5.9-orange?logo=swift)
![iOS](https://img.shields.io/badge/iOS-16+-lightgrey?logo=apple)
![SwiftUI](https://img.shields.io/badge/SwiftUI-%F0%9F%93%96-blue)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)

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
```
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
```

## 🛠️ Getting Started

Follow these steps to run the project locally:

### 1. Clone the Repository

```sh
git clone https://github.com/your-username/emoji-lover.git
cd emoji-lover
```

### 2. Open in Xcode

Navigate to the project folder and open the `Emoji Lover.xcodeproj` file.

### 3. Build & Run

Select a simulator or a connected iOS device and click the "Run" button (▶) in Xcode.

---

## ✅ TODOs

- [ ] Gamification — Implement a "Quiz Mode" or a "Matching Game" to test knowledge.
- [ ] Parental Features — Add the ability for parents to create their own custom learning lists.
- [ ] Content Expansion — Introduce real-world photos and sounds (e.g., actual animal noises).
- [ ] Haptic Feedback — Integrate subtle haptic taps for button presses to enhance the tactile experience.
- [ ] Localization — Add support for multiple languages.

---


## 📸 Screenshots

It is highly recommended to add screenshots of your app here. You can take screenshots from the simulator and drag them into this README.

| Category Grid | Learning Screen (Light) | Learning Screen (Dark) | Settings Screen |
|---------------|--------------------------|--------------------------|------------------|
| <img src="https://github.com/user-attachments/assets/a9f928e6-b9bd-4a44-8748-57caa02d328a" width="200"> | <img src="https://github.com/user-attachments/assets/f6bdf70e-4b56-4efa-a144-670bbc35fe7c" width="200"> | <img src="https://github.com/user-attachments/assets/3d7958fb-9eab-443f-98eb-10206cee27d9" width="200"> | <img src="https://github.com/user-attachments/assets/04a4fffa-e331-4fa0-9221-2aa25876d635" width="200"> |


---

## 📜 License

This project is licensed under the MIT License. See the LICENSE file for details.

---

## 💬 Want to Contribute?

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to add.

---


✨ Made with a passion for great iOS development.
