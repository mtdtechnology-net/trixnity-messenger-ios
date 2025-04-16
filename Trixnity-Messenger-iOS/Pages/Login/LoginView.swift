import Foundation
import SwiftUI

struct LoginView: View {
    
    // MARK: - StateObject

    @StateObject var viewModel: LoginViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text("Login with username / password")
                .fontWeight(.bold)
            TextField("Username", text: $viewModel.username)
                .autocorrectionDisabled()
                .autocapitalization(.none)
            TextField("Password", text: $viewModel.password)
                .autocorrectionDisabled()
                .autocapitalization(.none)

            if viewModel.canLogin {
                Button {
                    viewModel.login()
                } label: {
                    Text("Login")
                }
            }
        }
    }
}
