import Foundation

public protocol ImageCacheProtocol {
    /// Gets an image from the cache, if no value is available, fetches it asynchronously loads by `URL`.
    func getImage(for mediaURL: URL?) async throws -> CachedImage

    /// Gets an image from the cache.
    func getImageFromCache(for mediaURL: URL?) throws -> CachedImage?
}
