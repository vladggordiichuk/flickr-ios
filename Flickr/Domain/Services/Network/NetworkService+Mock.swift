import Foundation
import Combine

final class MockNetworkService: NetworkServiceProtocol {
    // MARK: - Parameters

    var expectedFetchResult: FetchResult = .success

    // MARK: - Fetch Protocols

    func fetchImageData(_ url: URL) async throws -> Data {
        guard let fileURL = try getBundleURL(forFileName: "sample_image", withExtension: "jpg")
        else { throw URLError(.badURL) }

        return try Data(contentsOf: fileURL)
    }

    func fetchPublicFeedPublisher(with tags: String) -> AnyPublisher<[FeedItem], any Error> {
        do {
            guard let fileURL = try getBundleURL(forFileName: "photos_public", withExtension: "json")
            else { throw URLError(.badURL) }

            let data = try Data(contentsOf: fileURL)
            let publicFeedJSON = try APIJSONDecoder().decode(PublicFeedJSON.self, from: data)
            let items = publicFeedJSON.items.map { FeedItem.init(from: $0) }
            return Just(items)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

    // MARK: - Helper Methods

    private func getBundleURL(forFileName fileName: String, withExtension fileExtension: String) throws -> URL? {
        switch expectedFetchResult {
        case .success: 
            return Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        case .empty:
            return Bundle.main.url(forResource: fileName + ".empty", withExtension: fileExtension)
        case .noConnection: throw URLError(.notConnectedToInternet)
        }
    }
}

extension MockNetworkService {
    enum FetchResult {
        case success
        case empty
        case noConnection
    }
}
