# Crefin Frontend - Flutter Mobile App

A beautiful, modern Flutter mobile application for freelance finance management with dark/light theme support and smooth animations.

## 🎯 Overview

The Crefin mobile app provides freelancers with an intuitive interface to manage their finances on the go. Built with Flutter for cross-platform compatibility (iOS, Android, Web).

## ✨ Features

### Implemented
- ✅ **Dynamic Island Navigation Bar** - iOS-inspired floating bottom navigation with blur effect
- ✅ **Dark/Light Theme Toggle** - Seamless theme switching with smooth animations
- ✅ **Settings Screen** - Comprehensive settings management with multiple sections:
  - Profile Information
  - Invoice Settings
  - Tax Settings
  - Preferences
  - Data & Privacy
  - Sign Out
- ✅ **Income Screen** - Track and display income entries
- ✅ **Smooth Scrolling** - Optimized scroll behavior with no overscroll indicators
- ✅ **Responsive Design** - Adapts to different screen sizes

### Color Palette

**Light Mode:**
- Background: `#ECECEC`
- Cards: `#FFFFFF`
- Text: `#000000`

**Dark Mode:**
- Background: `#000000` (True black - OLED friendly)
- Cards: `#1C1C1E`
- Text: `#FFFFFF`

**Accent Colors:**
- Green: `#34C759`
- Orange: `#FF9500`
- Blue: `#007AFF`
- Purple: `#AF52DE`
- Red: `#FF3B30`

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **UI Components:** Custom widgets with Material Design
- **Animations:** Built-in Flutter animations
- **State Management:** StatefulWidget

## 📁 Project Structure
```
lib/
├── main.dart                 # App entry point & navigation
├── colors.dart              # Color palette definitions
└── screens/
    ├── settings.dart        # Settings screen
    └── income.dart          # Income tracking screen
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
```bash
   git clone https://github.com/YOUR_USERNAME/crefin-frontend.git
   cd crefin-frontend
```

2. **Install dependencies**
```bash
   flutter pub get
```

3. **Run the app**
```bash
   # On iOS Simulator
   flutter run -d ios

   # On Android Emulator
   flutter run -d android

   # On Chrome (Web)
   flutter run -d chrome
```

## 🎨 Key UI Features

### Dynamic Island Navigation
- Floating bottom navigation bar
- Blur effect with semi-transparent background
- Smooth animations on tab selection
- White circular highlight for active tabs

### Theme System
- System-based default theme
- Manual toggle in settings
- Instant theme switching
- Consistent colors across all screens

### Scroll Behavior
- Bouncy physics on iOS
- No overscroll indicators
- Content scrolls under navbar
- Proper padding for navbar clearance

## 📱 Screens

1. **Dashboard** - Overview of finances (placeholder)
2. **Income** - Track income entries with scrollable list
3. **Finances** - Financial overview (placeholder)
4. **AI Insights** - AI-powered analytics (placeholder)
5. **Settings** - Comprehensive app settings

## 🔄 Current Development Phase

This is a **learning project** focused on:
- Full-stack development skills
- Flutter/Dart proficiency
- Modern UI/UX design
- Backend integration (coming soon)

## 📝 To-Do

- [ ] Connect to backend API
- [ ] Implement dashboard screen
- [ ] Add invoice management
- [ ] Integrate ML features
- [ ] Add data visualization charts
- [ ] Implement authentication flow

## 👨‍💻 Development

Built as a hands-on learning project to master:
- Flutter mobile development
- State management
- UI/UX design principles
- API integration
- Cross-platform development

## 📄 License

MIT

## 🤝 Contributing

This is a personal learning project, but feedback and suggestions are welcome!

---

**Status:** 🚧 In Active Development