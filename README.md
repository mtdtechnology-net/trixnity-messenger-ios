# Trixnity Messenger iOS

**iOS Example App for Trixnity Messenger**

This is an example iOS app demonstrating how to use the [Trixnity Messenger SDK](https://gitlab.com/connect2x/trixnity-messenger) built on top of the [Trixnity Matrix SDK](https://gitlab.com/famedly/trixnity), using Kotlin Multiplatform Mobile (KMM).

## Overview

The project serves as a reference implementation for integrating Trixnity Messenger in an iOS application while following modern iOS architectural patterns and keeping a clean separation between shared Kotlin logic and SwiftUI-based UI.

### Key Features

- Built with **MVVM architecture**, promoting separation of concerns.
- Uses **Decompose** for navigation and ViewModel management.
- Relies on the **default navigation stack** provided by Decompose.
- SwiftUI-based UI that communicates with shared Kotlin logic through shared ViewModels.
- All business logic and configuration are handled in the **ViewModels**, not in the UI layer.

## Architecture Highlights

- The shared Kotlin module contains all business logic, session management, and navigation setup.
- The iOS app uses **SwiftUI** only for rendering and reacting to state changes.
- We deliberately avoid placing logic inside SwiftUI views; instead, the UI observes state exposed by the shared ViewModels.
- This approach promotes a **testable**, **modular**, and **scalable** design.

## Getting Started

Clone the repository and open the Xcode workspace:

```bash
git clone https://github.com/mtdtechnology-net/trixnity-messenger-ios.git
cd trixnity-messenger-ios
open Trixnity-Messenger-iOS.xcworkspace
```

Ensure the shared Kotlin module (`trixnity-messenger`) is properly set up and compiled before running the iOS target.

## Requirements

- Xcode 15+
- SwiftUI
- Swift Pacakge Manager
- Shared module: [Trixnity Messenger](https://gitlab.com/connect2x/trixnity-messenger)

## License

MIT License (or your preferred license)