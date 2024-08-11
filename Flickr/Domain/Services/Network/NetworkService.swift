import Foundation
import Combine

final class NetworkService {
    // MARK: - Methods

    func getURL(for endpoint: APIEndpoint, with configuration: APIConfiguration = .default) throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = configuration.scheme
        urlComponents.host = configuration.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems.map(URLQueryItem.init)

        if let url = urlComponents.url {
            return url
        } else {
            throw URLError(.badURL)
        }
    }
}
