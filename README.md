# Telda’s Mobile Engineer Challenge

## Overview

This project is a simple movie app built using The Movie Database (TMDb) open API.
The app has two main views:

- **Movies List View:**
  - Search bar at the top to search movies by title
  - Shows movies grouped by year with title, overview, image, and watchlist status
  - When search bar is empty, shows popular movies (API A)
  - When searching, shows search results (API B)

- **Movie Details View:**
  Divided into 3 independently loaded sections:
  1. Movie details (API C): title, overview, image, tagline, revenue, release date, status, add to watchlist button
  2. List of up to 5 similar movies (API D)
  3. Casts of the similar movies (API E), grouped by Actors and Directors, sorted by popularity, showing top 5 of each

---

## Architecture

- Clean Architecture with **3 layers:**
  - **Data:** API implementations and repository implementations
  - **Domain:** Business entities, use cases, repository protocols
  - **Presentation:** MVVM pattern with UIKit

- UIKit used **fully coded** — no Storyboards
- Combine used for reactive bindings
- Navigation handled by **AppCoordinator**
- Factory pattern used to create ViewControllers
- Dependency injection managed by **DependencyContainer** using lazy vars
- Unit tests and builder patterns used for testing and code quality

---

## Persistence

- UserDefaults used for offline storage of simple movie IDs (watchlist)
- Justification:
  > Given that we’re only saving simple movie IDs, and there’s no need for querying or complex data relationships, UserDefaults is fast, lightweight, and ideal for this use case — even for several thousand entries.
  >
  > The logic is abstracted behind a `WishlistRepository` protocol so that switching to Core Data, Realm, or encrypted storage would have minimal impact on the rest of the codebase.

---

## Networking & Services

- Repository pattern abstracts data fetching
- Clean architecture separation of concerns:
  - Remote services (API calls) and local services (cache, storage) are abstracted behind protocols
  - Used Combine publishers to expose data streams to ViewModels
- Error handling with meaningful errors propagated to the UI

---

## Benefits of this Approach

- **Clean separation of concerns** improves maintainability and testability
- **MVVM + Combine** provides clear data flow and easy UI updates
- **Coordinator pattern** centralizes navigation logic, decouples view controllers
- **Factory & Dependency Injection** improves scalability and modularity
- Abstracted persistence allows future-proofing data storage strategies
- Fully coded UI ensures complete control over layout and behavior
- Unit tests improve reliability and help prevent regressions

---

## Requirements

- Supports iOS 14 through 18
- Supports all iPhone devices compatible with those iOS versions
- UIKit-based, with optional SwiftUI integration if needed
- Auto Layout used for all screen sizes

---

## APIs Used

- Popular Movies: https://developers.themoviedb.org/3/movies/get-popular-movies
- Search Movies: https://developers.themoviedb.org/3/search/search-movies
- Movie Details: https://developers.themoviedb.org/3/movies/get-movie-details
- Similar Movies: https://developers.themoviedb.org/3/movies/get-similar-movies
- Movie Credits: https://developers.themoviedb.org/3/movies/get-movie-credits

---

## How to Run

- Clone the repo
- Open `TeldaMovieApp.xcodeproj`
- Add your TMDb API key in the appropriate config file or Info.plist
- Build and run on iOS Simulator or device

---

## Contact

If you have any questions or feedback, feel free to reach out.

---
