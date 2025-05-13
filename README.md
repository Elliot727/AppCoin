# AppCoin

AppCoin is a simple iOS app that fetches and displays cryptocurrency data using the CoinPaprika API. The app shows a list of coins with basic details and allows users to view more information about a selected coin.

## Features

* **Coin List**: Displays a list of cryptocurrencies fetched from the CoinPaprika API.
* **Coin Detail View**: Allows users to view detailed information about a selected coin, such as its description, started date, and links.
* **Loading State**: A progress view is shown while data is being fetched.
* **Error Handling**: If there's an error fetching data, the app shows an error message with a retry option.

## Technologies Used

* **SwiftUI**: UI framework for building the app’s interface.
* **Swift Concurrency (async/await)**: For network requests to fetch coin data asynchronously.
* **SOLID Principles**: Ensuring the code is maintainable, flexible, and scalable.
* **CoinPaprika API**: The backend service providing cryptocurrency data.

## Architecture and Design

The app follows modern software engineering practices and is designed using the **SOLID principles** to ensure clean and maintainable code.

### SOLID Principles Applied

* **S** - **Single Responsibility Principle (SRP)**: Each class and struct in the app has one responsibility. For example, `CoinService` handles fetching data, while the `Coin` struct represents the coin data.

* **O** - **Open/Closed Principle (OCP)**: The app’s components, like the network layer, can be easily extended for new API endpoints or mock data for testing purposes without modifying existing code. For example, `Networkable` can be expanded to support new data models or sources.

* **L** - **Liskov Substitution Principle (LSP)**: Subtypes can be substituted for their base types without breaking functionality. For instance, `CoinService` can be replaced with a mock service in tests, maintaining the same interface.

* **I** - **Interface Segregation Principle (ISP)**: Interfaces are designed to be as specific as possible. For example, `Networkable` and `CoinFetchable` provide clear, focused methods to fetch data and don’t overload with unnecessary functions.

* **D** - **Dependency Inversion Principle (DIP)**: High-level modules (like `CoinService`) depend on abstractions (e.g., `Networkable`), not on low-level modules (e.g., `URLSession`). This allows easier testing and decoupling of components.


### Key Files:

* **CoinService.swift**: Manages the network requests to the CoinPaprika API and returns the coin data to the view models.
* **CoinViewModel.swift**: Contains the business logic to manage coin data and map it to the view layer.
* **CoinCardView.swift & CoinDetailView\.swift**: UI components for displaying coin data.
* **Coin.swift** and **CoinDetail.swift**: The data models representing coins and their details.

## Getting Started

### Requirements

* iOS 18.0+
* Xcode 16.0+

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Elliot727/AppCoin.git
   ```

2. Open the project in Xcode:

   ```bash
   open AppCoin.xcodeproj
   ```

3. Build and run the project in the Xcode simulator or on a physical device.

### Running the Tests

To run the tests, open the Xcode workspace and select the **Test** button (or press `Cmd+U`).

## Contributing

We welcome contributions to this project! To contribute:

1. Fork the repository.
2. Create a new branch for your feature or fix.
3. Make your changes and ensure the tests pass.
4. Open a pull request describing your changes.

