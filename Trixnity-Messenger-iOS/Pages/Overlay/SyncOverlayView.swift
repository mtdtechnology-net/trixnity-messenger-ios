import Foundation
import SwiftUI
import TrixnityMessenger

struct SyncOverlayView: View {

    // MARK: - StateObject
    
    @StateObject var viewModel: SyncOverlayViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text("SyncStates: \(String(describing: viewModel.accountSyncStates))")
        }
    }
}

#Preview {
    SyncOverlayView(
        viewModel: SyncOverlayViewModel(PreviewSyncViewModel())
    )
}
