//
//  TimCoordinator.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import Foundation
import Combine
import SwiftUI
@preconcurrency import TrixnityMessenger

class TimCoordinator: ObservableObject {
    
    // MARK: - Published
    
    @Published var rootViewModel: RootViewModel?
    @Published var activeStack: RootRouter.Wrapper?
    @Published var isPresented: Bool = false
    
    // MARK: - Private
    
    private var matrixClient: (any MatrixMultiMessenger)?
    private var matrixMessenger: (any MatrixMessenger)?
    private var cancelations: [Cancellation] = []
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    public init() {
        // Observe changes
        rootViewModel?.stack.subscribe { [weak self] value in
            self?.activeStack = value.active.instance
        }.store(in: &cancelations)
        
        // Observe is presented
        $isPresented
            .sink { [weak self] value in
                if !value, self?.rootViewModel != nil {
                    self?.closeMatrix()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Activate
    
    @MainActor
    func activate() async {
        matrixClient = try? await MatrixMultiMessengerCompanion.shared.create(
            configuration: {config in
                config.appName = "Trixnity Messenger iOS Demo"
                config.messenger = { messengerConfig in
                    messengerConfig.encryptLocalData = false
                }
            }
        )
        do {
            guard let matrixClient = matrixClient else { return }
            if matrixClient.activeProfile.value == nil {
                let profile: String
                if let firstProfile = matrixClient.profiles.value.keys.first {
                    profile = firstProfile
                } else {
                    profile = try await matrixClient.createProfile(settings: MatrixMultiMessengerProfileSettingsBase(displayName: "standard"))
                }
                try await matrixClient.selectProfile(profile: profile)
            }
            
            matrixClient.activeMatrixMessenger.bindWithCancellation { [weak self] messenger in
                self?.matrixMessenger = messenger
                self?.rootViewModel = messenger?.createRoot()
            }.store(in: &cancelations)
        } catch {
            print("Error \(error)")
        }
    }
    
    // MARK: - Back
    
    func closeMatrix() {
        Task { @MainActor in
            try? await matrixClient?.closeProfile()
            matrixClient?.close()
            matrixClient?.di.close()
            matrixClient = nil
            rootViewModel = nil
            matrixMessenger?.close()
            matrixMessenger?.di.close()
            matrixMessenger = nil
        }
    }
    
    // MARK: - Public methods
    
    @MainActor
    public func rootView() -> some View {
        RootViewWrapper()
        .environmentObject(self)
    }
    
    deinit {
        cancelations.forEach { $0.cancel() }
        cancelations.removeAll()
    }
}
