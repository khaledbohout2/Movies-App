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

1. **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd <repository-folder>
    ```

2. **Install CocoaPods dependencies:**
    Run this command inside the project folder:
    ```bash
    pod install
    ```

3. **Open the workspace file:**
    ```bash
    open MovieApp.xcworkspace
    ```

4. **Setup API Keys:**  
    This project requires TMDb API keys that are not included in the repository for security reasons.

    - Create a new file named `Secrets.xcconfig` in the project root.

    - Add the following content, replacing the placeholder values with your actual TMDb API keys:

        ```
        API_Read_Access_Token=your_actual_access_token_here
        API_KEY=your_actual_api_key_here
        ```

    - You can obtain your own TMDb API key by registering here: [https://www.themoviedb.org](https://www.themoviedb.org)

    - **Important:** After adding `Secrets.xcconfig`, set it in Xcode:

      - Select the project in the Project Navigator  
      - Go to the **Project** target > **Info** tab  
      - Under **Configurations**, set the `Secrets.xcconfig` file for both Debug and Release configurations  

5. **Build and run** the project on the iOS Simulator or a physical device.

---

## Next Steps

- Integrate an **offline-first approach** by adding a Core Data database to cache movie data and watchlist status.
- Remove the current use of UserDefaults for watchlist storage in favor of Core Data for improved data consistency and query capability.
- Implement syncing logic between Core Data local cache and remote TMDb API to handle offline scenarios gracefully.

---

## Contact

If you have any questions or feedback, feel free to reach out.
