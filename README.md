<p align="center">
  <img width=300 src=https://user-images.githubusercontent.com/56546505/167316108-73d100e7-ed1d-4f11-b8f1-063f291241fc.png>
</p>

<p align="center">
  This is an iOS app based on the TV show Rick & Morty. There you can access information about characters, episodes and locations that appear in the program. 
  Powered by GraphQL Api: 
<a target="_blank" href=https://rickandmortyapi.com/>Rick And Morty API</a>.
</p>

## Running the App

**Required:** XcodeGen installed (https://formulae.brew.sh/formula/xcodegen) 
1. Clone the repository
2. Execute `make generate` in the root folder of the project (this executes XCodeGen and Apollo CLI commands and opens the project)
3. It's ready!

## Tools

### Apollo

This project uses Apollo because of its seamless integration with GraphQL APIs in iOS apps, providing type-safe Swift code generation based on the GraphQL schema. This ensures a robust and error-free development experience, along with built-in caching for improved performance.
</br>
https://github.com/apollographql/apollo-ios

### XCodeGen

This project uses XcodeGen to streamline project setup and maintenance by defining project configuration in a YAML file, simplifying version control and ensuring consistency of the `.xcodeproj` file. 
</br>
https://github.com/yonaskolb/XcodeGen

### SwiftGen

This project uses  SwiftGen to automate the generation of type-safe Swift code for localized strings, assets, and colors.
</br>
https://github.com/SwiftGen/SwiftGen

## Architecture

This app follows clean architecture principles.

- **Presentation layer**: This layer was structured using MVVM-C (Model-View-ViewModel with Coordinators). This design pattern separates concerns by organizing code into models, views, view models, and coordinators, facilitating better code organization, testability, and navigation flow management.
</br>

- **Domain Layer**: In the domain layer, I employed the use of Use Cases. These encapsulate business logic into distinct units, promoting a clear separation of concerns and facilitating reusability and testability throughout the application.
</br>

- **Data layer**: In the data layer, I utilized repositories that leverage the Apollo API for data access. These repositories abstract the data retrieval process, providing a unified interface for interacting with GraphQL endpoints.

## Specifications
Natively implemented features:

- Image caching to optimize downloads
- Sugar syntax for handling constraints (over using third-party libraries like SnapKit)
- Debounce technique for search requests
- Paginated loading in UITableView
- Views with ViewCode (UIKit)
- Layout animations
- Unit testing
- Support for light and dark mode


## Screens


<table>
  <th>Light</th>
  <th>Dark</th>
    <tr>
        <td><img width="250" src="https://github.com/dudaporto/rick-and-morty-ios/assets/56546505/c6b4fb57-6c47-4cc2-b2d8-4b5469922f9e"></td>
        <td><img width="250" src="https://github.com/dudaporto/rick-and-morty-ios/assets/56546505/5ba59208-e2af-427a-8c03-eb96eb07f4c8"></td>
    </tr>
    <tr>
        <td><img width="250" src="https://github.com/dudaporto/rick-and-morty-ios/assets/56546505/4d50c234-93f9-4b07-b99f-11b663e85c55"></td>
        <td><img width="250" src="https://github.com/dudaporto/rick-and-morty-ios/assets/56546505/0b764610-6b38-4db3-99e4-9614d4e74f81"></td>
    </tr>
    <tr>
        <td><img width="250" src="https://github.com/dudaporto/rick-and-morty-ios/assets/56546505/6eecdd5d-848b-4c5d-a534-3fa79689ae94"></td>
        <td><img width="250" src="https://github.com/dudaporto/rick-and-morty-ios/assets/56546505/dd646e0a-c484-4427-a7a5-2271fbc37f6d"></td>
    </tr>
<table>
