import SwiftUI

public struct AccessibleLabeledContentStyle: LabeledContentStyle {
    // MARK: - Parameters

    @Environment(\.dynamicTypeSize.isAccessibilitySize) var isAccessibilitySize

    private var isVerticalLayout: Bool {
        isAccessibilitySize
    }

    // MARK: - Views

    public func makeBody(configuration: Configuration) -> some View {
        layout {
            configuration.label

            if !isVerticalLayout {
                Spacer()
            }

            configuration.content
                .foregroundStyle(Color.secondary)
        }
    }

    private var layout: AnyLayout {
        if isVerticalLayout {
            AnyLayout(VStackLayout(alignment: .leading))
        } else {
            AnyLayout(HStackLayout())
        }
    }
}

extension LabeledContentStyle where Self == AccessibleLabeledContentStyle {

    /// A labeled content style that resolves its appearance based
    /// on the current dynamic type size.
    public static var accessible: AccessibleLabeledContentStyle { .init() }
}
