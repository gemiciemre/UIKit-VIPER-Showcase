# UIKit-VIPER-Showcase

An educational iOS project showcasing how to build modular and testable apps using **VIPER architecture** with **UIKit**.

## 📌 Project Overview
This project demonstrates the implementation of VIPER (View, Interactor, Presenter, Entity, Router) architecture in a UIKit-based iOS application.  
The goal is to highlight how to structure an app in a **clean, scalable, and maintainable way**.

## 🛠️ Tech Stack
- **Language:** Swift
- **Framework:** UIKit
- **Architecture:** VIPER
- **Design Pattern Support:** Dependency Injection, Protocol-Oriented Programming

## 🧩 VIPER Module Structure

Each feature in the app is divided into the following layers:

- **View**  
  Responsible for UI and user interactions. Communicates only with the Presenter.  

- **Interactor**  
  Contains business logic and data manipulation. Talks only to the Presenter.  

- **Presenter**  
  Acts as the middleman between View and Interactor. Handles presentation logic.  

- **Entity**  
  Defines the data models used by the Interactor.  

- **Router**  
  Manages navigation and module creation.  
  
  View <–> Presenter <–> Interactor
↑                           ↓
└──────────── Router ───────┘
(Entities provide data models)

## 🚀 Features
- Product listing module
- Clean separation of concerns
- Easy to extend and test
- UIKit-based UI with VIPER module structure

## 📂 Project Structure

UIKit-VIPER-Showcase
│── Modules
│   └── Product
│       ├── View
│       ├── Interactor
│       ├── Presenter
│       ├── Entity
│       └── Router
│── Resources
│── Supporting Files

---

## ⚡ Getting Started

### Prerequisites
- Xcode 15+
- iOS 16+
- Swift 5.9+

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/UIKit-VIPER-Showcase.git
   
   cd UIKit-VIPER-Showcase
   open UIKit-VIPER-Showcase.xcodeproj
   
   Cmd + R

## 🧪 Future Improvements
- Unit tests for Interactor and Presenter
- Networking layer integration
- CoreData or Realm support for persistence

---

## 📜 License
This project is open source and available under the [MIT License](LICENSE).
