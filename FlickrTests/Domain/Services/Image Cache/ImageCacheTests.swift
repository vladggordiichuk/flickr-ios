import XCTest
@testable import Flickr

final class ImageCacheTests: XCTestCase {
    // MARK: - Parameters

    private var networkService: MockNetworkService!
    private var sut: ImageCacheProtocol!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        networkService = MockNetworkService()
        sut = ImageCache(networkService: networkService)
    }

    override func tearDown() {
        super.tearDown()
        networkService = nil
        sut = nil
    }

    // MARK: - Tests

    /// Testing happy scenario for `getImage()` method
    func test_getImage() async throws {
        // Arrange
        guard let url = URL(string: "https://flickr.com")
        else { throw URLError(.badURL) }

        // Assert
        XCTAssertNil(try sut.getImageFromCache(for: url))

        // Act
        let remoteImage = try await sut.getImage(for: url)

        // Assert
        XCTAssertEqual(
            remoteImage.originalImageSize,
            CGSize(width: 240, height: 180)
        )

        // Act
        let cachedImage = try sut.getImageFromCache(for: url)

        // Assert
        XCTAssertNotNil(cachedImage)
        XCTAssertEqual(remoteImage.originalImageSize, cachedImage?.originalImageSize)
    }

    /// Testing `.noConnection` scenario for `getImage()` method
    func test_getImage_withNoConnection() async throws {
        // Arrange
        networkService.expectedFetchResult = .noConnection
        guard let url = URL(string: "https://flickr.com")
        else { throw URLError(.badURL) }

        // Act
        do {
            _ = try await sut.getImage(for: url)
        } catch {
            // Assert
            XCTAssertEqual(error as? URLError, URLError(.notConnectedToInternet))
            XCTAssertNil(try sut.getImageFromCache(for: url))
        }
    }
}
