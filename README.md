# Basic Counter

A professional, feature-rich counter application built with Flutter. This project demonstrates a **Feature-First Architecture** and **Adaptive UI** principles, providing a native experience across Mobile, Tablet, and Desktop platforms.

## 🚀 Features

- **Adaptive Layouts**: Seamlessly switches between Mobile (Bottom Navigation) and Desktop/Tablet (Navigation Rail) views.
- **Unique Visuals**: Stylized counter display with animated transitions and circular progress indicators.
- **History Tracking**: Automatically logs every change with timestamps and visual indicators.
- **Advanced Settings**:
  - Customizable Step Size (1, 5, 10, 50, 100).
  - Working Dark Mode toggle.
- **Material 3**: Fully compliant with modern Material Design guidelines, including dynamic color seeding.

## 🏗️ Architecture

The project follows a **Feature-First (Folder-by-Feature)** architecture, ensuring high maintainability and scalability.

```text
lib/
├── app/                       # Global App Logic & Design System
├── features/                  # Independent Business Features
│   ├── counter/               # Main Counter logic & widgets
│   ├── history/               # History tracking & logs
│   └── settings/              # App configuration & preferences
└── main.dart                  # Clean entry point
```

## 🛠️ Getting Started

1. **Clone the repository**
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the application**:
   ```bash
   flutter run
   ```

## 📱 Platform Support

- **Android / iOS**: Mobile-optimized touch interface.
- **Windows / macOS / Linux**: Desktop-native Navigation Rail and keyboard-friendly layouts.
- **Web**: Fully responsive web implementation.

---
Built with ❤️ using Flutter & Material 3.
