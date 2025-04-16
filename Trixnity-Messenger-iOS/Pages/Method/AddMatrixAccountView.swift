import Foundation
import SwiftUI

struct AddMatrixAccountView: View {
    
    // MARK: - StateObject

    @StateObject var viewModel: AddMatrixAccountViewModelWrapper
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Add Matrix Account")
                .fontWeight(.bold)
            TextField("ServerUrl", text: $viewModel.serverURL)
                .autocorrectionDisabled()
            if viewModel.isDescoverable {
                
                Button {
                    viewModel.loginWithUserName()
                } label: {
                    Text("Login With Credentials")
                }
            } else {
                Text("Server not discoverable")
            }
            
            if let error = viewModel.error {
                Text("The error: \(error)")
            }
        }
    }
}
