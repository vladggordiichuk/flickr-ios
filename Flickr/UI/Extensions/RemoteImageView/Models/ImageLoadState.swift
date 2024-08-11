import SwiftUI

enum ImageLoadState: Equatable {
    case loading
    case loaded(uiImage: UIImage)
    case error
}
