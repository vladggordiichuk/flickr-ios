import XCTest
@testable import Flickr

final class FeedItemTests: XCTestCase {
    // MARK: - Tests

    /// Testing Initialization of `FeedItem` from `FeedItemJSON`
    func test_feedItem_init_from_json() async throws {
        // Arrange
        let sourceFeedItemJSON: FeedItemJSON = .valley
        let comparableFeedItem: FeedItem = .valley

        // Act
        let generatedFeedItem: FeedItem = .init(from: sourceFeedItemJSON, uuid: comparableFeedItem.id)

        // Assert
        XCTAssertEqual(comparableFeedItem, generatedFeedItem)
    }
}
