//
//  CancellationExtension.swift
//  Trixnity-Messenger-iOS
//
//  Created by Daniel Mandea on 15.04.2025.
//

import Foundation
import TrixnityMessenger

extension Cancellation {
    func store(in cancellables: inout [Cancellation]) {
        cancellables.append(self)
    }
}
