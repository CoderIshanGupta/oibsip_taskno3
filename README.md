# 📱Calculator

A powerful and responsive scientific calculator app built using **Flutter**. The calculator supports both **basic** and **scientific** modes, history tracking, inverse functions, and a custom keyboard interface.

## ✨ Features
- 📱 Responsive layout for phones and tablets
- 🧮 Basic and Scientific calculator modes
- 🔁 Toggle inverse trigonometric and exponential functions
- 📜 Calculation history with clear option
- 🧠 Custom expression evaluator using `math_expressions` package
- 🎨 Clean dark-themed UI inspired by real calculator interfaces


## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed
- Dart >= 2.17
- Android/iOS emulator or physical device

### Installation

1. **Clone the repo**
   ```bash
   git clone https://github.com/your-username/casio-calculator-clone.git
   cd casio-calculator-clone
2. **Get dependencies**
   ```bash
   flutter pub get
3. **Run the app**
   ```bash
   flutter run

### 🗂️ Project Structure
```
lib/
├── main.dart                      # App entry point
├── models/
│   └── history_item.dart          # HistoryItem model for storing calculations
├── screens/
│   └── home_screen.dart           # Main UI with logic for input, evaluation, history
├── widgets/
│   └── custom_keyboard.dart       # Dynamic keyboard based on calculator mode
```

### 📦 Packages Used
- `math_expressions`: For parsing and evaluating mathematical expressions
- `flutter/material.dart`: Built-in Flutter widgets and UI components

### 🛠️ Key Components
- **HomeScreen:** Central logic for the calculator, manages states like expression, result, mode, and history.
- **CustomKeyboard:** Adaptive grid-based button layout depending on basic/scientific and tablet/phone modes.
- **HistoryItem:** Lightweight model to represent past calculations.
- **Evaluator:** Logic for safely evaluating expressions and handling errors (e.g., division by zero).

### 📖 Expression Parsing Notes
- Supports basic operations: +, -, ×, ÷, ^
- Scientific functions like sin, cos, tan, ln, log, √, etc.
- Inverse functions toggle with Inv key
- Replaces symbols with Dart-valid operators before evaluation

## 🤝 Contributions
Pull requests and feedback are welcome!<br>
Feel free to fork and improve this project.
