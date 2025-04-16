//
//  LoginViewModel.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import TrixnityMessenger
import Combine

class LoginViewModel: ObservableObject {
    
    // MARK: - Publised
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var canLogin: Bool = false
    
    // MARK: - Private
    
    private let viewModel: PasswordLoginViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var cancellations: [Cancellation] = []
    
    // MARK: - Init
    
    init(viewModel: PasswordLoginViewModel) {
        self.viewModel = viewModel
        // Monitor Username
        $username
            .compactMap { $0 }
            .sink { [weak self] username in
                self?.viewModel.username.update(text: username, selection: nil, epoch: nil)
            }.store(in: &cancellables)
        // Monitor Password
        $password
            .compactMap { $0 }
            .sink { [weak self] password in
                self?.viewModel.password.update(text: password, selection: nil, epoch: nil)
            }.store(in: &cancellables)
        // Monitor can login
        viewModel.canLogin.bindWithCancellation { [weak self] value in
            self?.canLogin = value.boolValue
        }.store(in: &cancellations)
    }
    
    func login() {
        viewModel.tryLogin()
    }
    
    deinit {
        cancellations.forEach { $0.cancel() }
        cancellations.removeAll()
    }
}
