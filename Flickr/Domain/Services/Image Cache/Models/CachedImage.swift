import SwiftUI

final public class CachedImage {
    // MARK: - Parameters

    var originalImage: UIImage
    var thumbnailImage: UIImage
    var originalImageSize: CGSize
    static var thumbnailImageSize: CGSize { .init(width: 200, height: 200) }

    // MARK: - Init

    init(originalImage: UIImage, thumbnailImage: UIImage, originalImageSize: CGSize) {
        self.originalImage = originalImage
        self.thumbnailImage = thumbnailImage
        self.originalImageSize = originalImageSize
    }
}
