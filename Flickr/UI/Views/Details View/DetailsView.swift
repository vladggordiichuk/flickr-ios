import SwiftUI

struct DetailsView: View {
    // MARK: - Localized

    typealias Localized = Localization.Details
    typealias LocalizedGeneral = Localization.General

    // MARK: - Parameters

    @State var viewModel: DetailsViewModel

    @Environment(\.container) private var container

    @Environment(\.dismiss) private var dismiss

    @MainActor
    private var item: FeedItem {
        viewModel.item
    }

    @MainActor
    private var itemImageSize: CGSize? {
        viewModel.itemImageSize
    }

    // MARK: - Views

    var body: some View {
        NavigationStack {
            List {
                imageSectionView
                generalInfoSectionView
                datesSectionView
                additionalInfoSectionView
                buttonsSectionView
            }
            .navigationTitle(Localized.navigationTitle)
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                Button(LocalizedGeneral.Button.Done.title, systemImage: "xmark.circle.fill") {
                    dismiss()
                }
            }
        }
        .task {
            await viewModel.fetchImageSize()
        }
    }

    @ViewBuilder @MainActor
    private var imageSectionView: some View {
        Section {
            RemoteImageView(
                viewModel: RemoteImageViewModel(
                    container: container,
                    mediaURL: item.mediaURL,
                    transaction: Transaction(animation: .none)
                )
            )
            .scaledToFit()
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowBackground(Color.clear)
    }

    @ViewBuilder @MainActor
    private var generalInfoSectionView: some View {
        Section {
            LabeledContent(Localized.Label.ID.title, value: item.id.uuidString)
            LabeledContent(Localized.Label.Title.title, value: item.title)

            if let author = item.author {
                LabeledContent(Localized.Label.Author.title, value: author)
            }

            if let imageSize = itemImageSize {
                let imageWidth = imageSize.width
                let imageHeight = imageSize.height

                LabeledContent(Localized.Label.ImageSize.title) {
                    Text(Localized.Label.ImageSize.value(imageWidth, imageHeight))
                }
            }
        }
        .labeledContentStyle(.viewThatFits)
    }

    @ViewBuilder @MainActor
    private var datesSectionView: some View {
        Section {
            if let createdAt = item.createdAt {
                LabeledContent(
                    Localized.Label.CreationDate.title,
                    value: createdAt,
                    format: .dateTime
                )
            }

            if let publishedAt = item.publishedAt {
                LabeledContent(
                    Localized.Label.PublicationDate.title,
                    value: publishedAt,
                    format: .dateTime
                )
            }
        }
        .labeledContentStyle(.accessible)
    }

    @ViewBuilder @MainActor
    private var additionalInfoSectionView: some View {
        Section {
            if !item.tags.isEmpty {
                DisclosureGroup(Localized.Label.Tags.title) {
                    ForEach(item.tags, id: \.self) { tag in
                        Text(tag)
                    }
                }
            }

            if let description = item.description, !description.isEmpty {
                DisclosureGroup(Localized.Label.Description.title) {
                    Text(description)
                }
            }
        }
    }

    @ViewBuilder @MainActor
    private var buttonsSectionView: some View {
        Section {
            if let link = item.link {
                Link(destination: link) {
                    Label(
                        LocalizedGeneral.Button.OpenInSafari.title,
                        systemImage: "safari"
                    )
                }
                
                ShareLink(
                    LocalizedGeneral.Button.ShareLink.title,
                    item: link
                )
            }
        }
    }
}

#Preview {
    DetailsView(
        viewModel: DetailsViewModel(
            container: DIContainer.mock(),
            item: .valley
        )
    )
}
