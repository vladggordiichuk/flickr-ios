import SwiftUI

/// `ImageCache` allows fetching remote image and caching it in the temporary storage.
final public class ImageCache: ImageCacheProtocol {
    // MARK: - Parameters
    private var networkService: ImageFetchProtocol
    private var cache: NSCache<NSString, CachedImage> = .init()

    // MARK: - Init

    init(networkService: ImageFetchProtocol) {
        self.networkService = networkService
    }

    // MARK: - Methods
    
    public func getImage(for mediaURL: URL?) async throws -> CachedImage {
        guard let mediaURL else { throw ImageCacheError.badURL }

        let cacheKey = getCacheKey(from: mediaURL)

        if let cachedImage = try getImageFromCache(for: mediaURL) {
            return cachedImage
        } else {
            let data = try await networkService.fetchImageData(mediaURL)

            guard let uiImage = UIImage(data: data),
                  let originalImage = await uiImage.byPreparingForDisplay(),
                  let thumbnailImage = await uiImage.byPreparingThumbnail(ofSize: CachedImage.thumbnailImageSize)
            else { throw ImageCacheError.corruptedData }

            let cachedImage = CachedImage(
                originalImage: originalImage,
                thumbnailImage: thumbnailImage,
                originalImageSize: uiImage.size
            )

            cache.setObject(cachedImage, forKey: cacheKey)

            return cachedImage
        }
    }

    public func getImageFromCache(for mediaURL: URL?) throws -> CachedImage? {
        guard let mediaURL else { throw ImageCacheError.badURL }

        let cacheKey = getCacheKey(from: mediaURL)

        return cache.object(forKey: cacheKey)
    }

    // MARK: - Helper Methods
    
    /// Converts `URL` into the `NSCache` key.
    private func getCacheKey(from mediaURL: URL) -> NSString {
        mediaURL.absoluteString as NSString
    }
}
