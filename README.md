#  ProBase iOS App

---

# SwiftData “Full-Feature” Example App

This repository demonstrates how to build a SwiftUI app using **SwiftData** on iOS 17+ without a traditional ViewModel layer. The app explores multiple native iOS capabilities, including **Camera**, **Bluetooth (BLE)**, **MapKit**, and **Calendar/EventKit** integration.

## Table of Contents

1. [Overview](#overview)  
2. [Features](#features)  
3. [Project Structure](#project-structure)  
4. [Requirements](#requirements)  
5. [Setup & Installation](#setup--installation)  
6. [Usage](#usage)  
7. [Architecture](#architecture)  
8. [License](#license)

---

## Overview

This sample project showcases an iOS application that persists its data via **SwiftData**. SwiftData is Apple’s new persistence framework introduced in iOS 17, enabling seamless integration with SwiftUI. Rather than implementing a separate ViewModel layer (as often done in MVVM), we leverage SwiftData’s built-in observable `@Model` types directly in our SwiftUI views.

---

## Features

1. **SwiftData Integration**  
   - Models defined with `@Model` attributes.  
   - Simple CRUD functionality using SwiftData’s `ModelContext`.  
   - Example notes or tasks demonstrating how to store, edit, and delete entries.

2. **Camera**  
   - Access the device camera using SwiftUI’s `PhotosPicker` or `UIImagePickerController` via `UIViewControllerRepresentable`.  
   - Save captured images to SwiftData (optional).

3. **Bluetooth (Core Bluetooth)**  
   - Scan for nearby BLE devices.  
   - Display a list of discovered peripherals.  
   - (Optionally) connect and interact with specific characteristics.  
   - Demonstrates required permission strings and ephemeral data handling.

4. **MapKit**  
   - Show a map view with user location (requires location permission).  
   - Place pins or annotations for stored locations in SwiftData.  
   - Navigate to detail views for pinned places.

5. **Calendar (EventKit)**  
   - (Optional) integrate with the user’s existing Calendar/Reminders.  
   - Request permission for reading/writing events.  
   - Alternatively, demonstrate storing event-like data in SwiftData.

6. **Navigation & UI**  
   - SwiftUI `NavigationStack` for pushing/popping detail views.  
   - Optional TabView for major sections: Notes, Camera, BLE, Maps, Calendar.

---

## Project Structure

```
.
├── SwiftDataFullFeatureApp/
│   ├── Models/
│   │   ├── Note.swift             // Example SwiftData Model with @Model
│   │   ├── Device.swift           // Optional SwiftData model for BLE devices
│   │   ├── Place.swift            // Optional SwiftData model for map pins
│   └── Views/
│       ├── ContentView.swift      // Root view with Navigation
│       ├── Notes/
│       │   ├── NotesListView.swift
│       │   └── NoteDetailView.swift
│       ├── Camera/
│       │   └── CameraView.swift
│       ├── BLE/
│       │   ├── BLEScanView.swift
│       │   └── BLEDetailView.swift
│       ├── Map/
│       │   ├── MapView.swift
│       │   └── PinDetailView.swift
│       └── Calendar/
│           └── CalendarView.swift
├── README.md
└── Package.swift / Podfile / <other config files if used>
```

- **Models**: Holds all the SwiftData `@Model` definitions.  
- **Views**: SwiftUI screens for various app functionalities.

---

## Requirements

- **iOS 17+** (because SwiftData requires iOS 17 or macOS 14).  
- **Xcode 15+** (for SwiftData support).  
- **Swift 5.9+**.

You will also need to enable the relevant capabilities/permissions in your app:
- **Camera Usage**: Add `NSCameraUsageDescription` in `Info.plist`.
- **Bluetooth**: Add `NSBluetoothAlwaysUsageDescription` or `NSBluetoothPeripheralUsageDescription` in `Info.plist`.
- **Location** (for Maps): Add `NSLocationWhenInUseUsageDescription`.
- **Calendar** (for EventKit): Add `NSCalendarsUsageDescription` and/or `NSRemindersUsageDescription`.

---

## Setup & Installation

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/yourusername/SwiftDataFullFeatureApp.git
   cd SwiftDataFullFeatureApp
   ```

2. **Open in Xcode**  
   - Double-click `SwiftDataFullFeatureApp.xcodeproj` (or `.xcworkspace` if using Swift Packages/CocoaPods).

3. **Configure Bundle Identifier & Signing**  
   - In Xcode, go to your **Targets** → **Signing & Capabilities**.  
   - Set up a unique bundle identifier and your Apple Developer account.

4. **Add Privacy Descriptions (if not already)**  
   - In the `Info.plist`, ensure you have the keys:
     - `NSCameraUsageDescription`
     - `NSBluetoothAlwaysUsageDescription`
     - `NSLocationWhenInUseUsageDescription`
     - `NSCalendarsUsageDescription` / `NSRemindersUsageDescription`
   - Provide a user-facing reason for requesting these permissions.

5. **Build & Run**  
   - Select an iOS 17+ simulator or a real device.  
   - Press **Cmd + R** or use **Product → Run**.

---

## Usage

1. **Notes (SwiftData Example)**  
   - Tap the “Notes” tab (or screen) to see a list of stored notes.  
   - Add a new note, edit or delete existing ones.  
   - Changes persist automatically using SwiftData.

2. **Camera**  
   - In the “Camera” section, tap the capture button.  
   - Grant camera permission.  
   - Take a photo, which will be displayed/stored in your SwiftData model.

3. **BLE**  
   - Go to “Bluetooth” (BLE) screen.  
   - Start scanning for nearby BLE devices.  
   - See a list of discovered peripherals.  
   - (Optional) Tap a device to connect or explore services/characteristics.

4. **Map**  
   - The “Map” section shows user location (after granting permission).  
   - Any pinned places from SwiftData are shown on the map.  
   - Add or remove pins via SwiftData.

5. **Calendar** (Optional)  
   - The “Calendar” screen might show upcoming events or allow you to create events in the user’s calendar (using EventKit).  
   - If integrated with SwiftData, some local event data could be persisted.

---

## Architecture

Instead of a formal MVVM approach, this project uses **SwiftData’s** native `@Model` types for persistence and as the primary source of truth. Each SwiftUI view directly observes these models via property wrappers (like `@Query` or `@ObservedObject`), reducing the need for a separate ViewModel synchronization layer.

### Key Points

- **Models**  
  - Defined with `@Model`, automatically conforming to `Observable`.  
  - Changes in the model automatically update SwiftUI views.

- **SwiftData Context**  
  - A single `ModelContext` is typically provided at the app’s root (e.g., in `@main` struct).  
  - Child views fetch and mutate data within this context.

- **Navigation**  
  - Uses `NavigationStack` for a hierarchical flow, sometimes a TabView for top-level sections.

- **Permissions**  
  - Each feature (Camera, Bluetooth, Location, Calendar) requests permission from the user.  
  - Descriptions are set in `Info.plist`.

This pattern keeps the code relatively straightforward while demonstrating direct usage of SwiftData in each feature.

---

## License

This project is released under the [MIT License](LICENSE). You’re free to use, modify, and distribute it as needed. See the [LICENSE](LICENSE) file for more details.

---

**Enjoy exploring SwiftData and iOS system features!** If you have any questions or contributions, feel free to open an issue or a pull request.
