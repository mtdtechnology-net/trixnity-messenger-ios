//
//  RootViewModelWrapper.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import Combine
import TrixnityMessenger

class RootViewModelWrapper: ObservableObject {
    
    // MARK: - Published
    
    @Published var activeStack: RootRouter.Wrapper?
    
    // MARK: - Private
    
    private let viewModel: RootViewModel
    private var cancelations: [Cancellation] = []
    
    // MARK: - Init
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        // Observe changes 
        viewModel.stack.subscribe { [weak self] value in
            self?.activeStack = value.active.instance
        }.store(in: &cancelations)
    }
    
    deinit {
        cancelations.forEach { $0.cancel() }
        cancelations.removeAll()
    }
}
