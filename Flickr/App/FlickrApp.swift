import SwiftUI

@main
struct FlickrApp: App {
    // MARK: - Parameters

    @State private var container = DIContainer.default

    // MARK: - Views

    var body: some Scene {
        WindowGroup {
            FeedView(
                viewModel: FeedViewModel(
                    container: container
                )
            )
        }
        .environment(\.container, container)
    }
}
