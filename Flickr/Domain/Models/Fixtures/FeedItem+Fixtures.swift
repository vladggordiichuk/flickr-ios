import Foundation

extension FeedItem {
    static var valley: Self {
        .init(
            id: UUID(),
            title: "Valley",
            link: URL(string: "https://www.flickr.com/photos/64018849@N02/6117189965/"),
            mediaURL: URL(string: "https://live.staticflickr.com/6074/6117189965_e026487db2_n.jpg"),
            description: "a swiss valley in the evening sun",
            tags: ["valley", "evening", "sun", "switzerland"],
            author: "Ted Baker",
            authorId: "64018849@N02",
            createdAt: Date(timeIntervalSince1970: 100_000_000),
            publishedAt: Date(timeIntervalSince1970: 100_100_000)
        )
    }
}
