//
//  RootViewWrapper.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import SwiftUI

struct RootViewWrapper: View {
    
    // MARK: - EnvironmentObject
    
    @EnvironmentObject var coordinator: TimCoordinator
    
    // MARK: - Body
    
    var body: some View {
        Group {
            if let viewModel = coordinator.rootViewModel {
                RootView(
                    viewModel: RootViewModelWrapper(
                        viewModel: viewModel
                    )
                )
            } else {
                ProgressView()
            }
        }
        .task {
            await coordinator.activate()
        }
    }
}
