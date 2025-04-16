import SwiftUI
import TrixnityMessenger

struct RootView: View {
    
    // MARK: - StateObject
    
    @ObservedObject var viewModel: RootViewModelWrapper
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            switch viewModel.activeStack {
            case let matrixAccount as RootRouter.WrapperAddMatrixAccount:
                AddMatrixAccountView(
                    viewModel: AddMatrixAccountViewModelWrapper(
                        viewModel: matrixAccount.viewModel
                    )
                )
            case let passwordLogin as RootRouter.WrapperPasswordLogin:
                LoginView(
                    viewModel: LoginViewModel(
                        viewModel: passwordLogin.viewModel
                    )
                )
            case let mainStack as RootRouter.WrapperMain:
                MainView(
                    viewModel: MainViewModelWrapper(
                        viewModel: mainStack.viewModel
                    )
                )
            default: EmptyView()
            }
        }
    }
}

