import Foundation

enum APIEndpoint {
    case photosPublic(tags: String)
}

extension APIEndpoint {
    var path: String {
        switch self {
        case .photosPublic: return "/services/feeds/photos_public.gne"
        }
    }

    var queryItems: [String: String?] {
        switch self {
        case .photosPublic(let tags):
            return [
                "format": "json",
                "nojsoncallback": "1",
                "tags": tags
            ]
        }
    }
}
