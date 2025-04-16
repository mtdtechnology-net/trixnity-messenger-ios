//
//  RoomListElementViewModelWrapper.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import Combine
import UIKit
import TrixnityMessenger

class RoomListElementViewModelWrapper: ObservableObject, Identifiable {
    
    // MARK: - Published
    
    @Published var id: String
    @Published var roomImage: UIImage?
    @Published var roomName: String?
    @Published var roomInitials: String?
    
    // MARK: - Private
    
    private let viewModel: RoomListElementViewModel
    private var cancellations: [Cancellation] = []
    
    // MARK: - Init
    
    init(_ viewModel: RoomListElementViewModel) {
        self.viewModel = viewModel
        self.id = viewModel.roomId.full
        
        viewModel.roomName.bindWithCancellation { [weak self] value in
            self?.roomName = value
            self?.roomInitials = value?.prefix(2).uppercased()
        }.store(in: &cancellations)
        
        viewModel.roomImage.bindWithCancellation { [weak self] value in
            guard let data = value?.toNSData() else { return }
            self?.roomImage = UIImage(data: data)
        }.store(in: &cancellations)
    }
    
    deinit {
        cancellations.forEach { $0.cancel() }
        cancellations.removeAll()
    }
}
