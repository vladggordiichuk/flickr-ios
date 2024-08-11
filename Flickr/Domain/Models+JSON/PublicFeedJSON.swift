import Foundation

struct PublicFeedJSON: Decodable {
    let title: String
    let link: URL
    let description: String?
    let modified: Date?
    let generator: URL?
    let items: [FeedItemJSON]
}
