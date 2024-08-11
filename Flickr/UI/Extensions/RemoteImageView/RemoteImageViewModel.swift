import SwiftUI

@MainActor @Observable
final class RemoteImageViewModel {
    // MARK: - Parameters

    @ObservationIgnored
    let container: DIContainerProtocol

    var state: ImageLoadState = .loading

    @ObservationIgnored
    let mediaURL: URL?

    @ObservationIgnored
    let transaction: Transaction

    @ObservationIgnored
    let displaySize: ImageDisplaySize

    // MARK: - Init

    /// Loads and displays an image from the specified URL.
    /// - Parameters:
    ///   - mediaURL: The URL of the image to display.
    ///   - transaction: The transaction to use when the phase changes.
    ///   - displaySize: The size to use for the image. The default value is `.original`.
    init(
        container: DIContainerProtocol,
        mediaURL: URL?,
        transaction: Transaction = .init(animation: .default),
        displaySize: ImageDisplaySize = .original
    ) {
        self.container = container
        self.mediaURL = mediaURL
        self.transaction = transaction
        self.displaySize = displaySize
    }

    // MARK: - Interaction Methods

    func fetchImage() async {
        do {
            let cachedImage = try await container.imageCache.getImage(for: mediaURL)

            withTransaction(transaction) {
                switch displaySize {
                case .original:
                    state = .loaded(uiImage: cachedImage.originalImage)
                case .thumbnailImage:
                    state = .loaded(uiImage: cachedImage.thumbnailImage)
                }
            }
        } catch {
            state = .error
        }
    }
}
