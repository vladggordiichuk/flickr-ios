import Foundation

public struct FeedItem: Identifiable, Equatable {
    public let id: UUID
    let title: String
    let link: URL?
    let mediaURL: URL?
    let description: String?
    let tags: [String]
    let author: String?
    let authorId: String?
    let createdAt: Date?
    let publishedAt: Date?
}

public extension FeedItem {
    init(from feedItemJSON: FeedItemJSON, uuid: UUID = UUID()) {
        id = uuid
        title = feedItemJSON.title
        link = feedItemJSON.link
        mediaURL = feedItemJSON.media.m
        description = feedItemJSON.description
        tags = feedItemJSON.tags?.components(separatedBy: " ") ?? []
        author = feedItemJSON.author
        authorId = feedItemJSON.authorId
        createdAt = feedItemJSON.dateTaken
        publishedAt = feedItemJSON.published
    }
}
