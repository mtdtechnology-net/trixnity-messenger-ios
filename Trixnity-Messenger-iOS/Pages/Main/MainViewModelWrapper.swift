//
//  MainViewModelWrapper.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import Combine
import TrixnityMessenger

class MainViewModelWrapper: ObservableObject {
    
    // MARK: - Private
    
    @Published var activeInitialSyncStack: InitialSyncRouter.Wrapper?
    @Published var activeRoomListRouterStack: RoomListRouter.Wrapper?
    
    // MARK: - Private
    
    private let viewModel: MainViewModel
    private var cancelations: [Cancellation] = []
    
    // MARK: - Init
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        // Observe initialSyncStack
        viewModel.initialSyncStack.subscribe { [weak self] value in
            self?.activeInitialSyncStack = value.active.instance
        }.store(in: &cancelations)
        // Observe roomListRouterStack
        viewModel.roomListRouterStack.subscribe { [weak self] value in
            self?.activeRoomListRouterStack = value.active.instance
        }.store(in: &cancelations)
    }
    
    deinit {
        cancelations.forEach { $0.cancel() }
        cancelations.removeAll()
    }
}
