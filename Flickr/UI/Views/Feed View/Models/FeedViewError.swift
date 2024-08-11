import Foundation

enum FeedViewError: LocalizedError {
    case insufficientQuery

    // MARK: - Implementation

    var errorDescription: String? {
        switch self {
        case .insufficientQuery: return "You should enter 3, or more characters to proceed."
        }
    }
}
