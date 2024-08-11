import XCTest
@testable import Flickr

final class DetailsViewModelTests: XCTestCase {
    // MARK: - Parameters

    private var networkService: MockNetworkService!
    private var sut: DetailsViewModel!

    // MARK: - Lifecycle

    @MainActor
    override func setUp() {
        super.setUp()
        networkService = MockNetworkService()
        sut = DetailsViewModel(
            container: DIContainer.mock(
                networkService: networkService
            ),
            item: .valley
        )
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - Tests

    /// Testing happy scenario for `fetchImageSize()` method
    @MainActor
    func test_fetchImageSize() async throws {
        // Assert
        XCTAssertNil(sut.itemImageSize)

        // Act
        await sut.fetchImageSize()

        // Assert
        XCTAssertEqual(
            sut.itemImageSize,
            CGSize(width: 240, height: 180)
        )
    }

    /// Testing `.noConnection` scenario for `fetchImageSize()` method
    @MainActor
    func test_fetchImageSize_withNoConnection() async throws {
        // Act
        networkService.expectedFetchResult = .noConnection

        // Assert
        XCTAssertNil(sut.itemImageSize)

        // Act
        await sut.fetchImageSize()

        // Assert
        XCTAssertNil(sut.itemImageSize)
    }
}
