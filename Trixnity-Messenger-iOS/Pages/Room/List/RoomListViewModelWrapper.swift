//
//  RoomListViewModelWrapper.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import Combine
import TrixnityMessenger

class RoomListViewModelWrapper: ObservableObject {
    
    // MARK: - Published
    
    @Published var elements: [RoomListElementViewModelWrapper] = []
    @Published var title: String = ""
    
    // MARK: - Init
    
    private let viewModel: RoomListViewModel
    private var cancellations: [Cancellation] = []
    
    init(_ viewModel: RoomListViewModel) {
        self.viewModel = viewModel
        self.title = "Rooms 0"
        
        viewModel.elements.bindWithCancellation { [weak self] value in
            self?.elements = value.map { RoomListElementViewModelWrapper($0) }
            self?.title = "Rooms \(value.count)"
        }.store(in: &cancellations)
    }
    
    deinit {
        cancellations.forEach { $0.cancel() }
        cancellations.removeAll()
    }
}
