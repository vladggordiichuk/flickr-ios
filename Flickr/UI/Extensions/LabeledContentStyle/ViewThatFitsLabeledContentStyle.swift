import SwiftUI

public struct ViewThatFitsLabeledContentStyle: LabeledContentStyle {
    // MARK: - Views

    public func makeBody(configuration: Configuration) -> some View {
        let label = configuration.label
        let content = configuration.content
            .foregroundStyle(Color.secondary)

        ViewThatFits {
            HStackLayout {
                label
                Spacer()
                content
            }

            VStackLayout(alignment: .leading) {
                label
                content
            }
        }
    }
}

extension LabeledContentStyle where Self == ViewThatFitsLabeledContentStyle {

    /// A labeled content style that resolves its appearance based
    /// on the available space.
    public static var viewThatFits: ViewThatFitsLabeledContentStyle { .init() }
}
