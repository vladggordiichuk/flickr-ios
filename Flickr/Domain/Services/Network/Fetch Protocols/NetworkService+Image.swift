import Foundation

extension NetworkService: ImageFetchProtocol {
    // MARK: - ImageFetchProtocol

    public func fetchImageData(_ url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
