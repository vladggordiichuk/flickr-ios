import Foundation

enum SystemImage {
    // MARK: - ExclamationMark

    enum ExclamationMark {
        static let triangle: String = "exclamationmark.triangle"
    }

    // MARK: - List

    enum List {
        enum Bullet {
            static let rectangle: String = "list.bullet.rectangle"
        }
    }

    // MARK: - Safari

    static let safari: String = "safari"

    // MARK: - Xmark

    enum Xmark {
        enum Circle {
            static let fill: String = "xmark.circle.fill"
        }
    }
}
