import SwiftUI

@MainActor @Observable
final class DetailsViewModel {
    // MARK: - Parameters

    private(set) var item: FeedItem
    private(set) var itemImageSize: CGSize?

    @ObservationIgnored
    private var container: DIContainerProtocol

    // MARK: - Init

    init(container: DIContainerProtocol, item: FeedItem) {
        self.container = container
        self.item = item
    }

    // MARK: - Interaction Methods

    func fetchImageSize() async {
        let mediaURL = item.mediaURL
        let imageCache = try? await container.imageCache.getImage(for: mediaURL)

        if let imageCache {
            itemImageSize = imageCache.originalImageSize
        }
    }
}
