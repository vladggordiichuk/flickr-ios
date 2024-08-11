import Foundation

/// Type for every UseCase that is stored within the DIContainer
public protocol DIContainerProtocol {
    var networkService: NetworkServiceProtocol { get }
    var imageCache: ImageCacheProtocol { get }
}

/// Container for all the dependencies needed by the project
final public class DIContainer: DIContainerProtocol {
    public let networkService: NetworkServiceProtocol
    public let imageCache: ImageCacheProtocol

    init(networkService: NetworkServiceProtocol, imageCache: ImageCacheProtocol) {
        self.networkService = networkService
        self.imageCache = imageCache
    }
}
