import SwiftUI
import TrixnityMessenger

struct RoomListElementView: View {
    
    @StateObject var viewModel: RoomListElementViewModelWrapper
    
    var body: some View {
        HStack {
            if let image = viewModel.roomImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 52, height: 52, alignment: .leading)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.gray, lineWidth: 2)
                    }
                    .shadow(radius: 1)
            } else {
                VStack(alignment: .center) {
                    Text(viewModel.roomInitials ?? "XO")
                        .padding(5)
                }
                .frame(width: 52, height: 52, alignment: .leading)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.gray, lineWidth: 1)
                }
                .shadow(radius: 1)
            }
            
            if let roomName = viewModel.roomName {
                Text(roomName)
            } else {
                Text("Unknown Room")
            }
        }
    }
}
