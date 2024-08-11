import Foundation
import Combine

public typealias NetworkServiceProtocol = ImageFetchProtocol
    & PublicFeedFetchProtocol

public protocol ImageFetchProtocol {
    func fetchImageData(_ url: URL) async throws -> Data
}

public protocol PublicFeedFetchProtocol {
    func fetchPublicFeedPublisher(with tags: String) -> AnyPublisher<[FeedItem], Error>
}
