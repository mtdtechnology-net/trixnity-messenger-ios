//
//  StateFlow.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import Combine
import TrixnityMessenger

extension SkieSwiftStateFlow where T: Sendable {
    func stream() -> AsyncStream<T> {
        AsyncStream { continuation in
            Task {
                for await element in self {
                    continuation.yield(element)
                }
                continuation.finish()
            }
        }
    }
    
    /// Binds the flow to a property setter and returns a Cancellation object.
    /// This creates a Task that runs until either the flow completes or the returned
    /// Cancellation object is cancelled.
    /// Use this when you need to cancel the subscription manually.
    func bindWithCancellation(to property: @escaping @MainActor (T) -> Void) -> Cancellation {
        let task = Task {
            for await presence in self.stream() {
                await MainActor.run {
                    property(presence)
                }
            }
        }
        
        return TaskCancellation(task: task)
    }
}
