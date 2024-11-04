# Green House Coding Challenge by Aylwing Olivas

### Steps to Run the App
1. Clone the repository using git clone https://github.com/aylwingo/green-house-coding-challenge.
2. Open the project in Xcode (version 16 or later).
3. Set the target device to a simulator or a connected device.
4. Run the app by clicking on the 'Run' button or pressing Cmd + R.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
- Architecture: I focused on creating a scalable and maintainable architecture using MVVM, incorporating a router and coordinator to manage navigation, which allows separation of concerns and easier testing. This approach helps keep the codebase organized and facilitates future updates.
- Concurrency: I used Swift Concurrency (async/await) to handle data fetching, ensuring the app remains responsive. Concurrency is important for a smooth user experience, especially when dealing with network calls. This approach also helps prevent crashes or unexpected behavior related to race conditions, improving overall app stability.
- WebView and Video Loading: I implemented WebKit to load web views and YouTube videos efficiently, leveraging its native capabilities to provide a smooth experience for the user.
- Performance Optimization: I implemented image caching to minimize unnecessary network calls and improve the app's performance. This reduces load times and provides a better user experience.
- Error Handling: I added graceful error handling for malformed data and empty data scenarios, as outlined in the requirements. Proper error handling ensures that users are informed about issues in a user-friendly manner.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I dedicated significant effort to ensure each part of the project was implemented thoughtfully and effectively. In total, I spent approximately 5 hours working on the project. The time spent was divided among various areas, including:
- Project Setup and Architecture
- Networking and Data Fetching
- UI Development
- Image Caching and Performance Optimization
- Unit Testing

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
- Unit Testing Over UI Testing: I prioritized unit testing over UI or integration testing, as solid unit tests were preferred in the challenge. This helped ensure the core logic was thoroughly validated, providing a strong foundation for further development.
- Multiple Screen Implementation: I chose to implement multiple views, including a main table displaying recipes, detailed views with additional information such as videos, web views for embedded content, and a search bar to easily filter recipes. This decision was made to enhance the user experience by providing easy navigation and comprehensive content.
- Manual Image Caching: Instead of using a third-party library for image caching, I implemented a basic custom caching solution to maintain control over the caching logic. This allowed me to demonstrate my understanding of caching mechanisms.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The UI/UX could still be further enhanced, although I implemented a solid design focusing on usability and clarity. I would add more visual appeal and interactive elements to elevate the overall user experience.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
None. I chose not to include external dependencies to keep the project lightweight and to demonstrate my ability to implement core functionalities without relying on third-party solutions. I implemented a native web view using WebKit to handle web content, showcasing the effective use of built-in frameworks.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
- I aimed to create production-ready code. I would focus on adding more polish to the UI, including animations and accessibility features.
- The malformed and empty data scenarios were handled by displaying appropriate messages to the user, ensuring a smooth experience even when data issues occur.
- I used dependency injection for better testability and separation of concerns, which makes the codebase more modular and easier to extend in the future.
