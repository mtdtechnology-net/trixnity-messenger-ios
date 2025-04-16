//
//  AddMatrixAccountViewModelWrapper.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import TrixnityMessenger
import Combine

class AddMatrixAccountViewModelWrapper: ObservableObject {
    
    // MARK: - Published
    
    @Published var serverURL: String = ""
    @Published var isDescoverable: Bool = false
    @Published var matrixMethods: Set<AnyHashable> = []
    @Published var error: String?
    
    // MARK: - Private
    
    private var viewModel: AddMatrixAccountViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var cancelations: [Cancellation] = []
    private var method: AddMatrixAccountMethodPassword?
    
    // MARK: - Init
    
    init(viewModel: AddMatrixAccountViewModel) {
        self.viewModel = viewModel
        
        // Observe changes
        viewModel.serverDiscoveryState.bindWithCancellation { [weak self] value in
            switch value {
            case let success as AddMatrixAccountViewModelServerDiscoveryStateSuccess:
                for method in success.addMatrixAccountMethods {
                    if let method = method as? AddMatrixAccountMethodPassword {
                        self?.method = method
                    }
                }
                self?.isDescoverable = true
            default:
                self?.isDescoverable = false
            }
        }.store(in: &cancelations)
        
        // Observe is presented
        $serverURL
            .sink { value in
                viewModel.serverUrl.update(text: value, selection: nil, epoch: nil)
            }
            .store(in: &cancellables)
    }
    
    func loginWithUserName() {
        guard let method = method else {
            error = "No method found"
            return
        }
        viewModel.selectAddMatrixAccountMethod(addMatrixAccountMethod: method)
    }
    
    deinit {
        cancelations.forEach { $0.cancel() }
        cancelations.removeAll()
    }
}
