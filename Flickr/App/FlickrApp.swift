import SwiftUI

@main
struct FlickrApp: App {
    
    @State private var container = DIContainer.default

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
