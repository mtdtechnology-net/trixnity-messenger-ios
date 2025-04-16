//
//  StartupView.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import SwiftUI

enum Route: Hashable {
    case detail(message: String)
    case matrix
}

struct StartupView: View {
    
    // MARK: - State
    
    @State private var path = NavigationPath()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Button("Go to Matrix") {
                    path.append(Route.matrix)
                }
                
                Button("Open Detail Page") {
                    path.append(Route.detail(message: "Detail Page"))
                }
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let message):
                    Text(message)
                case .matrix:
                    LoadView()
                }
            }
        }
    }
}
