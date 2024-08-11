import Foundation

public struct FeedItemJSON: Decodable {
    let title: String
    let link: URL?
    let media: Self.Media
    let description: String?
    let tags: String?
    let author: String?
    let authorId: String?
    let dateTaken: Date?
    let published: Date?
}

public extension FeedItemJSON {
    struct Media: Decodable {
        let m: URL?
    }
}
