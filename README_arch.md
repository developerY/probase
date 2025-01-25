#  <#Title#>

**Short answer**: You _can_ still use MVVM with SwiftData, but it’s more awkward than it is with (for example) Core Data + MVVM or an Android‐style Repository + ViewModel stack. Apple’s new SwiftData system leans heavily on an “active record” style in which your data model objects are observed directly in SwiftUI. If you try to add a separate ViewModel layer, you then have to manually keep your ViewModel state in sync with changes in the SwiftData “model,” which is exactly what folks like Paul Hudson are objecting to.

---

## Why SwiftData clashes with typical MVVM

1. **Active Record vs. MVVM**  
   SwiftData’s `@Model` types _are themselves_ `ObservableObject`s, which means SwiftUI knows how to re-render automatically when properties on the model change. This is basically an “active record” pattern—your model objects know about persistence and can be observed directly in the UI.  
   - With MVVM, you would typically put your logic in a separate “ViewModel” object, which _wraps_ the model.  
   - With SwiftData, if you wrap your model in another layer, you’ll end up duplicating data and changes must be synced in both directions.

2. **Manual Data Synchronization**  
   By default, SwiftData wants to be the single source of truth. If you place a second data store (the ViewModel’s own properties) between the SwiftData model and your UI, you must ensure your MVVM layer and the SwiftData model never get out of sync. This can quickly become boilerplate or bug‐prone, and it defeats the convenience SwiftData is providing.

3. **Apple’s Sample Code**  
   Apple’s own SwiftData samples (e.g. _Backyard Birds_) pretty much skip the “middle-man” approach. They show SwiftUI views binding directly to SwiftData model objects. Hence folks saying “Apple is promoting Active Record”—because that’s essentially what the samples do.

---

## Does that mean MVVM is forbidden?

No—Apple has _not_ declared “no MVVM.” Rather, SwiftData is simply _optimized_ to work in a more direct style. If your use case requires heavy domain logic, advanced transformations, or a testable boundary between “database objects” and “UI,” you can still keep a ViewModel:

- **You’d implement** 
  1. A SwiftData model (`@Model`).
  2. A ViewModel that references the model objects and handles business logic.
  3. A SwiftUI view that observes the ViewModel.

- **But you must manage sync** between the ViewModel and the SwiftData model. For instance, if the ViewModel changes a property, it must write back to the SwiftData `@Model`—and likewise if SwiftData changes, the ViewModel must reflect that. It can get messy.

**In many smaller SwiftUI + SwiftData apps**, the simplest approach is:
1. Keep your logic in SwiftData “model” types directly, or in small helper types.  
2. Bind those models to your SwiftUI views with the SwiftData property wrappers.  
3. Skip a formal “ViewModel” layer unless you really need it.

Ultimately, **the architecture you choose depends on your app’s complexity**. SwiftData doesn’t bar you from using MVVM; it just makes MVVM more work than it used to be with Core Data, so some folks are skipping it and letting SwiftData manage the data binding for them.


---

It **can** feel that way in smaller apps or straightforward data flows, because SwiftData is designed to be the “one stop” for data + updates. By default, SwiftData’s `@Model` objects already behave as observable single sources of truth—so layering a ViewModel on top can create redundancy and syncing overhead.

**However**, it’s not quite so black and white:

1. **Simpler Apps**  
   - For simple or mid‐sized applications where your SwiftData models and relationships are well‐designed, you may get by (and even prefer) letting SwiftUI bind directly to them. In that scenario, an extra ViewModel layer doesn’t offer much benefit and does indeed add friction.

2. **Complex/Enterprise Apps**  
   - In large, long‐lived apps with complex business logic, you often need a separate layer that orchestrates multiple data sources, caches, network calls, transformations, etc. A ViewModel can serve as that layer, isolating your SwiftData model from UI concerns.  
   - Yes, you’ll have to ensure they stay in sync, but in many enterprise‐style apps, you’re likely already orchestrating multiple data sources anyway—so a dedicated ViewModel or “domain model” layer can be worth it.

So in **many typical SwiftData use cases**, using a separate ViewModel to basically duplicate the `@Model` objects is indeed redundant. But in apps with complicated logic where you want a testable boundary or you need to combine data from multiple repositories (e.g., SwiftData plus remote services plus user preferences), a ViewModel layer can still pay off.

In short:  
- For **smaller, purely SwiftData–backed** projects, you can skip a formal MVVM approach.  
- For **bigger apps** with lots of logic, it might still make sense to keep that “middle layer,” as long as you accept the overhead and plan your syncing carefully.
