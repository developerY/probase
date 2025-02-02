#  Connect Devices with Streams


### **Scenario 1: Bluetooth Device (e.g., Dexcom, OmniPod)**

Real-time device communication often uses **CoreBluetooth**. CoreBluetooth itself doesn't natively support async/await, making **Combine** the more straightforward choice when wrapping delegates into publishers.

#### **With Combine (recommended for BLE)**

```swift
import Combine
import CoreBluetooth

class GlucoseMonitorManager: NSObject, ObservableObject {
    @Published var glucoseData: [GlucoseDataPoint] = []
    private var centralManager: CBCentralManager!
    private var devicePeripheral: CBPeripheral?
    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    private func connectToDevice() {
        centralManager.scanForPeripherals(withServices: nil)
        
        // Combine hooks (pseudo)
        // Use Combine extensions to capture Bluetooth events.
    }
}

extension GlucoseMonitorManager: CBCentralManagerDelegate, CBPeripheralDelegate {
    // Handle device discovery, connection, and data updates.
}
```

In this scenario, **Combine** works well because Bluetooth communication relies on asynchronous delegate callbacks. You can wrap these delegates in publishers using Combine extensions or libraries like **CombineBluetooth**.

---

### **Scenario 2: REST/WebSocket API**

If you're integrating with a cloud service, structured concurrency works smoothly, especially for **async REST** or **WebSocket streams**.

#### **Structured Concurrency Example**
```swift
import SwiftUI

class GlucoseDataService: ObservableObject {
    @Published var glucoseData: [GlucoseDataPoint] = []

    func startLiveUpdates() {
        Task {
            await fetchGlucoseUpdatesFromServer()
        }
    }

    private func fetchGlucoseUpdatesFromServer() async {
        while true {
            if let newData = await fetchData() {
                await MainActor.run {
                    glucoseData.append(newData)
                }
            }
            try? await Task.sleep(nanoseconds: 5_000_000_000)
        }
    }

    private func fetchData() async -> GlucoseDataPoint? {
        // Simulate fetching data from a REST endpoint
        return GlucoseDataPoint(date: Date(), level: Double.random(in: 4.5...9.5))
    }
}
```

Here, **structured concurrency** integrates well with async web services, reducing boilerplate code.

---

### **Scenario 3: Real Device SDK**

Many proprietary SDKs (e.g., Dexcom, Medtronic) often provide their own callback mechanisms for real-time data. These don't inherently favor Combine or structured concurrency, but you can adapt either pattern:

- **Combine:** Easily wrap callbacks using `PassthroughSubject` or `Future`.
- **Structured Concurrency:** Less intuitive since SDK callbacks require manual `async` bridging.

---

### **Comparison Summary for Real Devices**

| **Device Type**        | **Best Approach**                         | **Why**                                         |
|------------------------|--------------------------------------------|-------------------------------------------------|
| BLE Devices            | Combine                                    | CoreBluetooth uses delegate callbacks.           |
| REST/WebSocket         | Structured Concurrency                     | Works well with async/await for network requests |
| Proprietary Device SDK | Combine (or both with async bridging)       | Callback-heavy, adaptable to Combine             |

---

### **Final Thoughts**

For **BLE devices**, **Combine** is easier due to CoreBluetooth's reliance on delegate callbacks. For cloud APIs or mock data, **structured concurrency** is cleaner. If your app will use both, you can combine these approaches.
