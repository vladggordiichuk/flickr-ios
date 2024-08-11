import Foundation
import Combine

extension NetworkService: PublicFeedFetchProtocol {
    // MARK: - PublicFeedFetchProtocol

    public func fetchPublicFeedPublisher(with tags: String) -> AnyPublisher<[FeedItem], Error> {
        do {
            let url = try getURL(for: .photosPublic(tags: tags))
            return URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: PublicFeedJSON.self, decoder: APIJSONDecoder())
                .map { $0.items.map { FeedItem.init(from: $0) } }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
