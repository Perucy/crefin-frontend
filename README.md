# Crefin Frontend - Flutter Mobile App

A beautiful, modern Flutter mobile application for freelance finance management with dark/light theme support and smooth animations.

## 🎥 Demo Video

[https://github.com/user-attachments/assets/YOUR-VIDEO-ID-HERE](https://docs.google.com/videos/d/1OxZAU81WZkqBRiyDhWj5FK0MzTHXXgAoKnwePxmJzNQ/edit?usp=sharing)

*Watch the app in action - featuring dashboard analytics, invoice management, and seamless dark/light mode switching.*

---

## 🎯 Overview

The Crefin mobile app provides freelancers with an intuitive interface to manage their finances on the go. Built with Flutter for cross-platform compatibility (iOS, Android, Web).

## ✨ Features

### Implemented
- ✅ **Dashboard Screen** - Comprehensive financial overview with:
  - Revenue, expenses, and profit analytics
  - Payment time tracking
  - AI-powered high-risk client alerts
  - Revenue vs expenses chart
  - Active goals progress tracking
  - Recent activity feed
  - Quick action buttons
- ✅ **Invoices & Clients Screen** - Manage invoices and client relationships:
  - Tab-based navigation (Invoices/Clients)
  - Invoice filtering (All, Sent, Paid, Overdue)
  - Search functionality
  - Status tracking with visual indicators
- ✅ **Income Tracking Screen** - Log and monitor income entries
- ✅ **Settings Screen** - Comprehensive settings management:
  - Profile information
  - Invoice and tax settings
  - Preferences with dark/light mode toggle
  - Data export
- ✅ **Dynamic Island Navigation Bar** - iOS-inspired floating bottom navigation with blur effect
- ✅ **Dark/Light Theme Toggle** - Seamless theme switching with smooth animations
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
- **Number Formatting:** intl package

## 📁 Project Structure
```
lib/
├── main.dart                    # App entry point & navigation
├── colors.dart                 # Color palette definitions
└── screens/
    ├── dashboard.dart          # Dashboard with analytics
    ├── invoices_clients.dart   # Invoices & clients management
    ├── income.dart             # Income tracking
    └── settings.dart           # Settings screen
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- iOS Simulator / Android Emulator / Physical Device

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

### Dashboard
- **Financial Overview Cards** - Revenue, expenses, net profit, pending invoices
- **Payment Analytics** - Average payment time with industry comparison
- **Risk Management** - AI-powered high-risk client detection with gradient alerts
- **Visual Charts** - Revenue vs expenses bar chart with 6-month history
- **Goal Tracking** - Progress bars for active financial goals
- **Activity Feed** - Real-time updates on invoices, payments, and expenses
- **Quick Actions** - One-tap access to create invoice, log expense, add client

### Invoices & Clients
- **Tab Navigation** - Switch between invoices and clients view
- **Smart Filtering** - Filter invoices by status (all, sent, paid, overdue)
- **Real-time Search** - Search invoices by client name or invoice ID
- **Status Indicators** - Visual icons showing payment status
- **Client Risk Scores** - AI-calculated risk assessment for each client

### Theme System
- System-based default theme detection
- Manual toggle in settings
- Instant theme switching across all screens
- Consistent colors and smooth transitions

### Scroll Behavior
- Bouncy physics for iOS-style feel
- No overscroll indicators for clean appearance
- Content scrolls smoothly under navbar
- Proper padding for navbar clearance

## 📱 Screens

1. **Dashboard** - Financial overview with analytics and insights
2. **Income** - Track income entries with scrollable list
3. **Invoices & Clients** - Manage invoices and client relationships
4. **AI Insights** - AI-powered analytics (placeholder)
5. **Settings** - Comprehensive app settings with theme toggle

## 🔄 Current Development Phase

This is a **learning project** focused on:
- Full-stack development skills
- Flutter/Dart proficiency
- Modern UI/UX design principles
- Backend integration (coming soon)
- Machine learning integration (coming soon)

## 📝 To-Do

- [ ] Connect to Node.js backend API
- [ ] Integrate ML client risk prediction model
- [ ] Add invoice PDF generation
- [ ] Implement authentication flow
- [ ] Add data visualization charts library
- [ ] Build AI insights screen
- [ ] Add animations and micro-interactions
- [ ] Implement pull-to-refresh

## 👨‍💻 Development

Built as a hands-on learning project to master:
- Flutter mobile development
- State management patterns
- UI/UX design principles
- API integration
- Cross-platform development best practices

## 🎓 Learning Goals

This project demonstrates proficiency in:
- Building production-ready mobile interfaces
- Implementing complex layouts and navigation
- Managing application state effectively
- Creating reusable widget components
- Following Flutter best practices
- Responsive and adaptive design

## 📄 License

MIT

## 🤝 Contributing

This is a personal learning project, but feedback and suggestions are welcome!

---

**Built with ❤️ using Flutter**

**Status:** 🚧 In Active Development
