//
//  SyncOverlayViewModel.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import Combine
import TrixnityMessenger

class SyncOverlayViewModel: ObservableObject {
    
    // MARK: - Published
    
    @Published var accountSyncStates: [String: String] = [:]
    
    // MARK: - Private
    
    private let viewModel: SyncViewModel
    private var cancellations: [Cancellation] = []
    
    // MARK: - Init
    
    init(_ viewModel: SyncViewModel) {
        self.viewModel = viewModel
        // Bind accountSyncStates
        viewModel.accountSyncStates.bindWithCancellation { [weak self] value in
            self?.accountSyncStates = value.map { items in
                items.reduce(into: [:]) { result, pair in
                    result["\(pair.key)"] = "\(pair.value)"
                }
            } ?? [:]
        }.store(in: &cancellations)
    }
    
    deinit {
        cancellations.forEach { $0.cancel() }
        cancellations.removeAll()
    }
}
