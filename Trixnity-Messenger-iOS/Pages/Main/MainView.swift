import SwiftUI
import TrixnityMessenger

struct MainView: View {
    
    // MARK: - StateObject
    
    @StateObject var viewModel: MainViewModelWrapper
    
    // MARK: - Body
    
    var body: some View {
        switch viewModel.activeInitialSyncStack {
        case _ as InitialSyncRouter.WrapperNone:
            VStack {
                ProgressView {
                    Text("Loading ....")
                }
            }
        case let sync as InitialSyncRouter.WrapperSync:
            SyncOverlayView(
                viewModel: SyncOverlayViewModel(sync.viewModel)
            )
        default:
            Text("unknown sync state")
        }
    
        switch viewModel.activeRoomListRouterStack {
        case let roomList as RoomListRouter.WrapperList:
            RoomListView(
                viewModel: RoomListViewModelWrapper(roomList.viewModel)
            )
        default:
            Text("Something else than the room list")
        }
    }
}
