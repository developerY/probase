#  Features

Here’s a practical way to structure a new iOS app—especially if you want to explore multiple frameworks (Calendar, Maps, BLE, Camera) without a ViewModel layer. The core idea is to start small, prove out your SwiftData setup, then layer in the more complex system frameworks step by step:

---

## 1. **Project Setup & Basic SwiftData Integration**

1. **Create a new SwiftUI + SwiftData project in Xcode.**  
   - Use the Xcode template that includes “SwiftData” if available (iOS 17+).  
   - Create one or two simple `@Model` entities just to confirm data saving and retrieval works.  
   - Keep the initial UI minimal—maybe just a list of these model objects and a detail view.

2. **Establish Navigation**  
   - Rely on SwiftUI’s `NavigationStack`, which is simpler in iOS 16+ than earlier patterns.  
   - Make sure you have a top-level `ContentView` that can flow to other screens.

3. **Decide on an “Active Record” approach** (no separate ViewModel)  
   - Bind your `@Model` objects directly to SwiftUI Views using `@Bindable` (if needed).  
   - Verify you can read and write model properties directly from the UI.

**Why start here?**  
You get your basic architecture and data persistence in place, ensuring that the rest of the features can store or retrieve data as needed.

---

## 2. **Add a Simple “Global” Feature—like a Notes or Logging System**

Before diving into specialized features like Maps or BLE, try implementing a basic “Notes” or “To‐Do” component in your app. This is purely SwiftUI + SwiftData:  
- Make a `Note` `@Model` with properties (title, body, date, etc.).  
- Display a list of `Note`s in your main UI.  
- Tap a note to edit in a detail screen.  
- Confirm that SwiftData is persisting everything correctly.

**Why?**  
It’s a straightforward way to test your SwiftData usage without any additional frameworks. You’ll confirm that your “active record” approach is comfortable and that your navigation flows are working.

---

## 3. **Incorporate the Camera (or Photos) Functionality**

Camera is fairly straightforward with modern SwiftUI but still touches iOS permissions and the system camera picker. Start with either the `PhotosPicker` (SwiftUI) or a `UIViewControllerRepresentable` bridging to `UIImagePickerController`. Steps:

1. **Set up permissions** (iOS will prompt for camera access).  
2. **Add a “take photo” button** on your main screen or some detail screen.  
3. **Store the photo**—maybe in the `@Model` object’s property (you might store the image data as `Data` or reference a path/URL).  
4. **Display the photo** in the UI.

**Why?**  
- It’s a manageable first “native feature.”  
- Verifies that you can handle system permissions.  
- Good test for linking SwiftUI views to data (images).

---

## 4. **Add BLE (Bluetooth Low Energy)**

Next, tackle Bluetooth—this uses **Core Bluetooth** on iOS:

1. **Core Bluetooth Setup**  
   - Create a `CBCentralManager`.  
   - Implement required delegate methods for scanning devices.  
   - Keep track of discovered peripherals in SwiftData or an in-memory list.

2. **Permissions**  
   - For iOS 13+, you’ll need to add Bluetooth usage descriptions in your Info.plist.  
   - If your use-case includes scanning in the background, you may need more specific entitlements.

3. **Connect & Interact**  
   - Decide on your data flow: do you store scanned devices in SwiftData as “DiscoveredPeripheral” models? Or do you just keep them in memory until the user picks a device?  
   - The trickiest part is how persistent you need the BLE device data to be. If ephemeral, keep it out of SwiftData.

4. **UI**  
   - Provide a list of discovered devices.  
   - Let the user tap to connect.  
   - Display read/write characteristics as needed.

**Why here?**  
- BLE is a more advanced system feature, requiring scanning and concurrency considerations.  
- This ensures your SwiftData architecture can handle ephemeral data (BLE devices) vs. persistent data.

---

## 5. **Add Maps (MapKit or Apple Maps)**

Adding a map is often simpler after you have your project structure and permission flows hammered out:

1. **MapKit Integration**  
   - Use SwiftUI’s `Map` view or a `UIViewRepresentable` if you want more advanced customization.  
   - Show user location (needs `NSLocationWhenInUseUsageDescription` in Info.plist).  
   - Possibly store location data in SwiftData if your app needs that.  
   - If your app has items or pins to display on the map, store them in SwiftData (like “Locations” or “Places”).

2. **Permissions**  
   - iOS will prompt the user for location permission.  
   - Decide if you need background location or just when-in-use.

3. **UI**  
   - Could show a map tab or a map screen that references data from SwiftData (like saved location pins).  
   - Tapping a pin might navigate to a detail screen that references the pinned `@Model`.

**Why here?**  
- Maps typically layer on top of location services or a data set of pinned places. By now, your app’s data handling is in place, so adding a new “Maps” screen is straightforward.

---

## 6. **Calendar / Reminders Integration**

This can mean a couple of things:

- **Using EventKit** to integrate with the user’s actual Calendar events.  
- **Building your own “calendar”** UI in SwiftUI (like a scheduling feature) and storing events in SwiftData.

1. **Permissions**  
   - If you’re tapping into the user’s real Calendar or Reminders, you’ll request permission via EventKit.  
   - If you’re building a custom in‐app calendar, no special system permission is required unless you want to sync with the system Calendar.

2. **UI**  
   - The simplest approach might be to store “events” in SwiftData.  
   - Use a SwiftUI date picker or a third-party calendar library (or roll your own calendar UI).  
   - If you want to actually read/write to the user’s system calendar, you’ll do so via EventKit APIs, then store references in SwiftData if needed.

**Why here?**  
- Calendar/Reminders typically rely on the user’s existing iOS data. By this stage, you already have practice requesting system permissions (camera, BLE, location).

---

## 7. **Polish & Cross-Feature Integration**

Finally, tie everything together:

- **App-Wide Navigation**  
  - Possibly add a TabView for the major sections: “Notes,” “Camera,” “Bluetooth,” “Map,” “Calendar,” etc.  
- **Search / Filter**  
  - Let users search or filter data in SwiftData.  
- **Sync / Sharing**  
  - If you want iCloud sync or share data across devices, SwiftData can be used with iCloud (similar to how Core Data does CloudKit).  

**Why here?**  
- By now you have multiple “vertical slices” of functionality. Polishing the overall app flow helps make it coherent.

---

### Summary of Recommended Order

1. **Basic SwiftData & SwiftUI Setup**  
   - Minimal model + list/details UI.  
2. **A Simple Feature (like a Notes screen) using SwiftData**  
   - Prove out data storage, retrieval, and SwiftUI binding.  
3. **Camera/Photos**  
   - Learn iOS permission handling, store images in SwiftData if needed.  
4. **BLE (Core Bluetooth)**  
   - Explore scanning, connecting, ephemeral vs. persistent data in SwiftData.  
5. **Maps (MapKit)**  
   - Add geolocation pins, location permissions, possibly store pinned places.  
6. **Calendar/Reminders**  
   - Either a custom in‐app schedule or integrate with EventKit.  
7. **Wrap Up & Polish**  
   - Combine features with cohesive navigation, possible iCloud sync, testing, etc.

This approach **gradually** introduces different system frameworks, so you can ensure each piece is working well with SwiftData’s “no‐ViewModel” approach before you move to the next.
