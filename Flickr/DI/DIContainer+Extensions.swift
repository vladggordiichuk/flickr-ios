import Foundation

extension DIContainer {
    static var `default`: Self {
        let networkService = NetworkService()
        let imageCache = ImageCache(networkService: networkService)

        return Self(
            networkService: networkService,
            imageCache: imageCache
        )
    }
}

extension DIContainer {
    static func mock(
        networkService: NetworkServiceProtocol = MockNetworkService(),
        imageCache: ImageCacheProtocol? = nil
    ) -> Self {
        let imageCache = imageCache ?? ImageCache(networkService: networkService)

        return Self(
            networkService: networkService,
            imageCache: imageCache
        )
    }
}
