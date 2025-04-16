//
//  LoadView.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import SwiftUI
import TrixnityMessenger

struct LoadView: View {
    
    // MARK: - @StateObject
    
    @StateObject var coordinator: TimCoordinator = TimCoordinator()
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("AOK Sample App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            Button {
                coordinator.isPresented = true
            } label: {
                Text("Chat with us")
                    .padding()
                    .foregroundStyle(Color.white)
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .fullScreenCover(isPresented: $coordinator.isPresented) {
            coordinator.rootView()
        }
    }
}

