import Foundation

struct APIConfiguration {
    let scheme: String
    let host: String
}

extension APIConfiguration {
    static let `default` = APIConfiguration(
        scheme: "https",
        host: "api.flickr.com"
    )
}
