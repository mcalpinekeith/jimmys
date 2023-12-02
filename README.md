# jimmys

Manage scheduling of workouts.

## Principles

Architecture adheres to the following principles:
- Domain-driven architecture, with the domain layer as the middle layer that describes our models, the use cases, and the possible failures we need to handle.
- Separation of concerns between the data layer and the UI layer, with no dependencies between them.
- Adherence to the Single Responsibility Principle (SRP).
- Test coverage of 100%.

## Domain layer

Defines how data is represented (MODELS) and handled (USES CASES) by the different components in the DATA and UI layers.
MODELS: 
- Contains a series of methods and properties (helpers) that are used by data or UI layer. 
FAILURES: 
- Identifies known issues and customize behavior when those issues occur.
- Minimizes the risk of having unhandled exceptions.
USE-CASES: 
- Defines the operations that the Data layer should expose to the UI layer.

## Data layer

Enables easy swapping of data sources without impacting the rest of the application.
MODULES: 
- Used exclusively by INTERACTORS.
- Handles communication with external components (i.e. databases, API clients).
- Act as background service or plugin that interact with native platforms. 
INTERACTORS: 
- Uses MODULES to implement the USE-CASES contracts.
- Handles business logic and data manipulation.
- Interfaces Data layer with the rest of the application.

## UI layer

Depend on the MODELS and USE-CASES.
VIEWS: 
- Builds the UI by READING a STATE and fire events (described in the VIEW MODEL CONTRACT) when the user interacts with it. 
- Delegates business logic and data access responsibilities to VIEW MODELS. 
- Contains everything related to WIDGETS and context-related logic. 
- Subscribing to a contract allows binding VIEWS and VIEW MODELS without a direct dependency, a VIEW will subscribe to a VIEW MODEL contract.
VIEW MODELS: 
- Interfaces the VIEW with the rest of the application.
- Uses USE-CASES to provide data and update the STATE in the VIEWS.
- Fire events as described in the VIEW CONTRACT.
STATES: 
- Holds a snapshot of all the variables needed to build a VIEW.
- Updated by the VIEW MODELS and read by the VIEWS. ChangeNotifier makes the VIEW aware when a change in the current STATE occurs.
WIDGETS: 
- Reusable components to be reused in different views.
ROUTER and ROUTES: 
- Manages the navigation and flow between different screens and views.

## A complete guide to a scalable app in Flutter

- [Part 1](https://medium.com/@gbaccetta/flutter-scalable-app-guide-part-1-architecture-8f60a2bbfe04)
- [Part 2](https://medium.com/@gbaccetta/a-complete-guide-to-a-scalable-app-in-flutter-part-2-data-layer-7629b6bb3835)
- [Part 3](https://medium.com/@gbaccetta/a-complete-guide-to-a-scalable-app-in-flutter-part-3-ui-layer-with-the-mvvm-pattern-716cb4210260)
- [Part 4](https://medium.com/@gbaccetta/a-complete-guide-to-a-scalable-app-in-flutter-part-4-complex-navigation-and-responsive-layout-73c96b6d8f12)
- [Part 5](https://medium.com/@gbaccetta/a-complete-guide-to-a-scalable-app-in-flutter-part-5-theming-and-appsettings-04eb9aad974c)

## FlutterFire CLI
Check version: flutterfire --version
Activate latest version: dart pub global activate flutterfire_cli

## Firebase CLI (firebase-tools)

[Firebase CLI for macOS](https://firebase.google.com/docs/cli#macos)

Show projects: firebase projects:list
Update to latest version: curl -sL https://firebase.tools | upgrade=true bash 
Login: firebase login:ci
Databases: firebase firestore:databases:list  --token 1//053Zw4i0VRbubCgYIARAAGAUSNwF-L9IrLGmwz0vGJAwoxZmTVJ62DHmMHUvGqs6Koso-kOCoezct7zV-iKopZQcIzz6onHgkN48 
Start emulators: firebase emulators:start

## Keyboard shortcuts

Go to definition: mouse wheel click
Find in files: mouse front side button
Find in all places: mouse back side button
