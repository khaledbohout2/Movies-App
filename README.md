Telda Mobile Engineer Challenge — Movie App
This repository contains my solution for the Telda Mobile Engineer Challenge — a simple movie app using The Movie Database (TMDb) API.

Challenge Overview
Create a movie app with two main views:

Movie List View:

Shows popular movies when search is empty.

Shows search results grouped by year with title, overview, image, and watchlist status.

Search bar for movie title input.

Movie Detail View:

Displays movie details (title, overview, image, tagline, revenue, release date, status, and watchlist button).

Shows up to 5 similar movies.

Displays top 5 actors and directors from the similar movies, grouped and sorted by popularity.

Use TMDb API endpoints for data.

Support iOS 14 to 18, all iPhone devices.

UIKit mandatory; SwiftUI optional.

Auto Layout required.

Architecture & Design
I applied Clean Architecture principles, separating the app into three main layers:

Layer    Responsibility    Technologies / Patterns Used
Data    API implementations, data repositories, offline storage    APIClient, Repository pattern, UserDefaults for offline data
Domain    Business entities, use cases, repository protocols    Plain Swift models, Use Cases for business logic, Protocol abstractions
Presentation    UI, view models, data binding, navigation    UIKit (programmatic, no storyboard), MVVM, Combine, AppCoordinator

Key components:
MVVM (Model-View-ViewModel) pattern in the Presentation layer to keep UI logic clean and testable.

Combine framework for reactive data binding between ViewModels and Views.

AppCoordinator pattern for navigation flow management, promoting separation of concerns.

Factory pattern to instantiate ViewControllers cleanly and consistently.

Dependency Container using lazy properties to manage dependencies efficiently and support easy testing and mocking.

Repository abstraction for data fetching, enabling swapping between remote API and local data seamlessly.

Services abstraction:

Local service (UserDefaults-based Watchlist storage).

Remote service (TMDb API client).

Offline Storage / Watchlist Management
Given the requirement to store only simple movie IDs for the user's watchlist, I chose to use UserDefaults:

"Since we only save simple movie IDs and have no need for complex queries or data relationships, UserDefaults is a lightweight and fast solution, ideal even for several thousand entries."

To maintain a clean architecture and future-proof the app:

Watchlist persistence is abstracted behind a WishlistRepository protocol.

This abstraction allows swapping to other storage mechanisms in the future (e.g., Core Data, Realm, Keychain) without impacting the rest of the app.

This approach demonstrates foresight and scalability — hallmarks of senior-level development.

Benefits of Chosen Technologies & Patterns
Technology / Pattern    Benefits
Clean Architecture    Clear separation of concerns, easier maintenance, testability, and scalability.
MVVM + Combine    Reactive UI updates, clean data flow, and better unit testing capabilities.
UIKit (programmatic)    Full control over UI, no storyboard merge conflicts, easier to review changes.
AppCoordinator    Centralized navigation logic, easier to maintain complex flows.
Factory Pattern    Simplifies view controller creation, improves code modularity.
Dependency Injection Container    Manages dependencies effectively, promotes loose coupling and easier testing.
Repository Pattern    Decouples data sources from business logic, easier to mock or extend.
UserDefaults for Watchlist    Lightweight, fast, and perfectly suited for simple key-value data storage.

How to Run
Clone the repo.

Open MovieApp.xcodeproj in Xcode.

Add your TMDb API key in Info.plist under the key API_Read_Access_Token.

Build and run on iOS 14+ simulator or device.

Testing
Unit tests cover ViewModels and Use Cases.

Mock repositories and services injected via dependency container for isolated tests.

Builders used for generating test data easily.

Summary
This project demonstrates:

Practical application of Clean Architecture and MVVM with Combine.

Strong understanding of UIKit best practices and programmatic UI development.

Effective error handling, dependency management, and navigation coordination.

Thoughtful offline data storage strategy with abstraction for scalability.

Clear, maintainable, and testable code reflecting senior-level iOS development skills.

Thank you for reviewing my solution!
Feel free to reach out if you have any questions.

