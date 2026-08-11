# 🗺️ Route Tracker App — Production-Level Flutter Application

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-green)
![Maps](https://img.shields.io/badge/Maps-Google%20Maps-purple)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

A scalable and production-oriented Route Tracking Application built using **Flutter**. This project demonstrates the implementation of **Clean Architecture** principles, separating the codebase into Domain, Data, and Presentation layers to ensure maintainability, testability, and scalability.

---

## 🚀 Project Overview

Route Tracker App is a cross-platform mobile application that simulates a real-world production environment [cite: 1, 2]. It allows users to:

- **Real-time Location Tracking:** Accurately track user movement using GPS [cite: 1, 2].
- **Interactive Maps:** View current location and past routes on a map [cite: 1, 2].
- **Route History:** Save and review previous trips with detailed stats (distance, duration) [cite: 1, 2].
- **Clean UI/UX:** Intuitive, and responsive design tailored for both Android and iOS [cite: 1, 2].

---

## 📸 Application Preview

> **[🎬 Click here to watch the App Demo Video!](https://drive.google.com/file/d/1zXVfTkvwz1CiGAMv8dXzTtx4aemBv8lR/view?usp=sharing)**

<p align="center">
  <img src="https://drive.google.com/uc?export=view&id=10fn1KaZT34TObkJnF_R3_HdAP2f89-Qo" height="400" alt="Screen 1"/>
  <img src="https://drive.google.com/uc?export=view&id=13qW-7WV3LaldSM9F8_DBjXeAXBSGbBjx" height="400" alt="Screen 2"/>
  <img src="https://drive.google.com/uc?export=view&id=12ycHYGEqv-8Ri8OGKca86skC4vDRghJX" height="400" alt="Screen 3"/>
</p>
<p align="center">
  <img src="https://drive.google.com/uc?export=view&id=1RAkoJy12KUs_16uF-F_GwEx3wvysatD8" height="400" alt="Screen 4"/>
  <img src="https://drive.google.com/uc?export=view&id=195-cnTgEmoN_cD_OhhOAZNMKsvuhjRK3" height="400" alt="Screen 5"/>
  <img src="https://drive.google.com/uc?export=view&id=1RPN0kbI1mzPvUh_nnXAdi-fnBEZd9MtY" height="400" alt="Screen 6"/>
</p>

<p align="center">
  <b>Clean UI • Real-Time Tracking • Google Maps</b>
</p>

---

## 🏗️ Architecture & Design

The project strictly follows **Clean Architecture** divided into three independent layers [cite: 1, 2]:

1.  **Domain Layer:** The inner core containing Entities, Use Cases, and Repository Interfaces. It has **zero dependencies** on other layers.
2.  **Data Layer:** Handles data retrieval. It contains Models, Data Sources (Remote/Local), and Repository Implementations.
3.  **Presentation Layer:** The UI layer containing Screens, Widgets, and State Management.

### Folder Structure
```text
lib/
├── core/                # Shared utilities, constants, networking, and DI setup
├── features/
│   ├── tracker/         # Tracking Feature (Data, Domain, Presentation)
│   └── route_history/   # History Feature (Data, Domain, Presentation)
├── main.dart            # Entry point
└── ...
```

## 🛠 Tech Stack

| Technology | Role |
| :--- | :--- |
| **Flutter** | UI Framework |
| **Dart** | Programming Language |
| **Google Maps SDK** | Map Integration |
| **geolocator / location** | Location Services |
| **Clean Architecture** | Architectural Pattern |

---

## ⚙️ Installation & Setup
Follow these steps to run the project locally:

**1️⃣ Clone Repository**
```bash
git clone https://github.com/Moamed1010/Route-Tracker-App.git
```

**2️⃣ Navigate to Project Directory:**
```bash
cd Route-Tracker-App
```

**3️⃣ Install Dependencies:**
```bash
flutter pub get
```

**4️⃣ Configure API Key:**
* Obtain a valid **Google Maps API Key** [cite: 1, 2].
* Add the key to your Android `AndroidManifest.xml` and iOS `AppDelegate.swift` files as required by the Google Maps package [cite: 1, 2].

**5️⃣ Run the Application:**
```bash
flutter run
```

---

## 🤝 Contributing
Contributions are welcome! If you have any suggestions or improvements [cite: 1, 2]:

1. Fork the repository [cite: 1, 2].
2. Create a new branch (`git checkout -b feature-branch`) [cite: 1, 2].
3. Commit your changes [cite: 1, 2].
4. Push to the branch [cite: 1, 2].
5. Open a Pull Request [cite: 1, 2].

---

## 👨‍💻 Developer
**Mohamed Hassan Ali** [cite: 1, 2]  
Flutter Developer

Passionate about building scalable, maintainable, and production-ready mobile applications.

<p align="left">
  <a href="https://github.com/Moamed1010" target="_blank">
    <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
  </a>
</p>

⭐ If you found this project useful, please consider giving it a star!
README.md
Displaying README.md.
