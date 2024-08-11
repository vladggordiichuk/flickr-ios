import SwiftUI

struct RemoteImageView: View {
    // MARK: - Parameters

    @State var viewModel: RemoteImageViewModel

    // MARK: - Views

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let uiImage):
                Image(uiImage: uiImage)
                    .resizable()
            case .error:
                Image(systemName: "exclamationmark.triangle")
                    .imageScale(.large)
            }
        }
        .task {
            await viewModel.fetchImage()
        }
    }
}
