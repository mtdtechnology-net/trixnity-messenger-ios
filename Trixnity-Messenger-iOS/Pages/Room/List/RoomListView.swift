import Foundation
import SwiftUI
import TrixnityMessenger

struct RoomListView: View {
    
    // MARK: - EnvironmentObject

    @EnvironmentObject var coordinator: TimCoordinator
    
    // MARK: - StateObject

    @StateObject var viewModel: RoomListViewModelWrapper
    
    // MARK: - Init
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.elements) { element in
                    NavigationLink {
                        Text("\(element.id)")
                    } label: {
                        RoomListElementView(viewModel: element)
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        coordinator.isPresented.toggle()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
            .navigationTitle(viewModel.title)
        }
    }
}

#Preview {
    RoomListView(
        viewModel: RoomListViewModelWrapper(PreviewRoomListViewModel())
    )
}
