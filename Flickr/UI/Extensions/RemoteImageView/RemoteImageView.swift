import SwiftUI

/// A view that asynchronously loads and displays an image.
public struct RemoteImageView: View {
    // MARK: - Parameters

    @State var viewModel: RemoteImageViewModel

    // MARK: - Views

    public var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let uiImage):
                Image(uiImage: uiImage)
                    .resizable()
            case .error:
                Image(systemName: SystemImage.ExclamationMark.triangle)
                    .imageScale(.large)
            }
        }
        .task {
            await viewModel.fetchImage()
        }
    }
}

#Preview {
    RemoteImageView(
        viewModel: RemoteImageViewModel(
            container: DIContainer.mock(),
            mediaURL: FeedItem.valley.mediaURL
        )
    )
}
