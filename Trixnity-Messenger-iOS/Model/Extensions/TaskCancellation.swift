//
//  TaskCancellation.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import Foundation
import TrixnityMessenger

/// A concrete implementation of the Cancellation protocol that wraps a Task.
/// This allows for cancelling async tasks created by the bindWithCancellation method.
final class TaskCancellation: Cancellation {
    // MARK: - Properties
    
    /// The task that will be cancelled when cancel() is called
    private var task: Task<Void, Never>?
    
    // MARK: - Initialization
    
    /// Creates a new TaskCancellation that wraps the provided task
    init(task: Task<Void, Never>) {
        self.task = task
    }
    
    // MARK: - Cancellation
    
    /// Cancels the underlying task and clears the reference to it
    func cancel() {
        task?.cancel()
        task = nil
    }
}

