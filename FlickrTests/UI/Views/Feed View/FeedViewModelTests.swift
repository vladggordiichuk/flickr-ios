import XCTest
@testable import Flickr

final class FeedViewModelTests: XCTestCase {
    // MARK: - Parameters

    private var networkService: MockNetworkService!
    private var sut: FeedViewModel!

    // MARK: - Lifecycle

    @MainActor
    override func setUp() {
        super.setUp()
        networkService = MockNetworkService()
        sut = FeedViewModel(
            container: DIContainer.mock(
                networkService: networkService
            ),
            searchQueryPublisherDebounceFor: 0.1
        )
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - Tests

    /// Testing happy scenario for search flow
    @MainActor
    func test_state_andSearchResults() async throws {
        // Assert
        XCTAssertEqual(sut.state, .idle)
        XCTAssertEqual(sut.searchQuery, "")
        XCTAssertTrue(sut.searchResults.isEmpty)

        // Act
        sut.searchQuery = "valley"

        // Assert
        XCTAssertEqual(sut.state, .loading)
        XCTAssertTrue(sut.searchResults.isEmpty)

        // Act
        try await Task.sleep(for: .seconds(0.2))

        // Assert
        XCTAssertEqual(sut.state, .loaded)
        XCTAssertEqual(sut.searchResults.count, 20)
    }

    /// Testing error scenario for search flow
    @MainActor
    func test_state_andSearchResults_withEmptyFetch() async throws {
        // Arrange
        networkService.expectedFetchResult = .empty

        // Assert
        XCTAssertEqual(sut.state, .idle)
        XCTAssertEqual(sut.searchQuery, "")
        XCTAssertTrue(sut.searchResults.isEmpty)

        // Act
        sut.searchQuery = "valley"

        // Assert
        XCTAssertEqual(sut.state, .loading)
        XCTAssertTrue(sut.searchResults.isEmpty)

        // Act. Waiting for debounce.
        try await Task.sleep(for: .seconds(0.2))

        // Assert
        XCTAssertEqual(sut.state, .loaded)
        XCTAssertTrue(sut.searchResults.isEmpty)
    }

    /// Testing error scenario for search flow
    @MainActor
    func test_state_andSearchResults_withError() async throws {
        // Arrange
        networkService.expectedFetchResult = .noConnection

        // Assert
        XCTAssertEqual(sut.state, .idle)
        XCTAssertEqual(sut.searchQuery, "")
        XCTAssertTrue(sut.searchResults.isEmpty)

        // Act
        sut.searchQuery = "valley"

        // Assert
        XCTAssertEqual(sut.state, .loading)
        XCTAssertTrue(sut.searchResults.isEmpty)

        // Act
        try await Task.sleep(for: .seconds(0.2))

        // Assert
        XCTAssertEqual(sut.state, .error)
        XCTAssertTrue(sut.searchResults.isEmpty)
    }

    /// Testing `FeedItem` selection
    @MainActor
    func test_selectItem() async throws {
        // Assert
        XCTAssertNil(sut.selectedItem)

        // Arrange
        let item: FeedItem = .valley

        // Act
        sut.selectItem(item)

        // Assert
        XCTAssertEqual(sut.selectedItem, item)
    }
}
