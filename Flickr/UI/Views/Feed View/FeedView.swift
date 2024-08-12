import SwiftUI

struct FeedView: View {
    // MARK: - Localized

    typealias Localized = Localization.Feed
    typealias LocalizedGeneral = Localization.General

    // MARK: - Parameters

    @State var viewModel: FeedViewModel

    @Environment(\.container) private var container

    @Environment(\.dynamicTypeSize.isAccessibilitySize) private var isAccessibilitySize

    // MARK: - Views

    var body: some View {
        NavigationStack {
            ScrollView {
                switch viewModel.state {
                case .idle:
                    idleView
                case .loading:
                    loadingView
                case .loaded:
                    loadedView
                case .error:
                    errorView
                }
            }
            .navigationTitle("flickr.")
        }
        .searchable(
            text: $viewModel.searchQuery,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: Localized.SearchTextField.placeholder
        )
        .autocorrectionDisabled()
        .sheet(item: $viewModel.selectedItem) { item in
            DetailsView(
                viewModel: DetailsViewModel(
                    container: container,
                    item: item
                )
            )
        }
    }

    // MARK: - View States

    @ViewBuilder @MainActor
    private var idleView: some View {
        ContentUnavailableView(
            Localized.ContentUnavailable.Idle.title,
            image: "",
            description: Text(Localized.ContentUnavailable.Idle.description)
        )
    }

    @ViewBuilder @MainActor
    private var loadingView: some View {
        ProgressView()
    }

    @ViewBuilder @MainActor
    private var errorView: some View {
        ContentUnavailableView(
            Localized.ContentUnavailable.Error.title,
            image: "exclamationmark.triangle",
            description: Text(Localized.ContentUnavailable.Error.description)
        )
    }

    @ViewBuilder @MainActor
    private var loadedView: some View {
        if viewModel.searchResults.isEmpty {
            emptyResultsView
        } else {
            resultsView
        }
    }

    @ViewBuilder @MainActor
    private var emptyResultsView: some View {
        ContentUnavailableView.search(text: viewModel.searchQuery)
    }

    @ViewBuilder @MainActor
    private var resultsView: some View {
        LazyVGrid(
            columns: [
                GridItem(
                    .adaptive(
                        minimum: isAccessibilitySize ? 150 : 100,
                        maximum: 200
                    ),
                    spacing: 1
                )
            ],
            spacing: 1,
            pinnedViews: []
        ) {
            ForEach(Array(viewModel.searchResults.enumerated()), id: \.element.id) { index, item in
                gridItemView(for: item, index: index)
            }
        }
    }

    // MARK: - Grid Item View

    @ViewBuilder @MainActor
    private func gridItemView(for item: FeedItem, index: Int) -> some View {
        Button(
            action: {
                viewModel.selectItem(item)
            },
            label: {
                Color(uiColor: .systemGray6)
                    .overlay {
                        RemoteImageView(
                            viewModel: RemoteImageViewModel(
                                container: container,
                                mediaURL: item.mediaURL,
                                transaction: Transaction(animation: .default),
                                displaySize: .thumbnailImage
                            )
                        )
                        .scaledToFill()
                    }
                    .aspectRatio(1, contentMode: .fill)
                    .clipped()
                    .contentShape(Rectangle())
            }
        )
        .buttonStyle(.plain)
        .contextMenu {
            if !item.title.isEmpty {
                Text(item.title)
                Divider()
            }

            seeDetailsButton(item: item)

            if let link = item.link {
                openInSafariButton(link: link)
                shareLinkButton(link: link)
            }
        } preview: {
            RemoteImageView(
                viewModel: RemoteImageViewModel(
                    container: container,
                    mediaURL: item.mediaURL,
                    transaction: Transaction(animation: .none)
                )
            )
        }
        .accessibilityLabel(getGridItemA11yLabel(for: item))
        .accessibilityInputLabels([Localized.Button.GridItem.a11yInputLabel(index)])
        .accessibilityActions {
            if let link = item.link {
                openInSafariButton(link: link)
                shareLinkButton(link: link)
            }
        }
    }

    // MARK: - Grid Item Buttons

    @ViewBuilder @MainActor
    private func seeDetailsButton(item: FeedItem) -> some View {
        Button(Localized.Button.SeeDetails.title, systemImage: "list.bullet.rectangle") {
            viewModel.selectItem(item)
        }
    }

    @ViewBuilder @MainActor
    private func openInSafariButton(link: URL) -> some View {
        Link(destination: link) {
            Label(
                LocalizedGeneral.Button.OpenInSafari.title,
                systemImage: "safari"
            )
        }
    }

    @ViewBuilder @MainActor
    private func shareLinkButton(link: URL) -> some View {
        ShareLink(
            LocalizedGeneral.Button.ShareLink.title,
            item: link
        )
    }

    // MARK: - Helper Methods

    func getGridItemA11yLabel(for item: FeedItem) -> String {
        if let author = item.author {
            return Localized.Button.GridItem.a11yLabel(item.title, author)
        } else {
            return item.title
        }
    }
}

#Preview {
    FeedView(viewModel: FeedViewModel(container: DIContainer.mock()))
}
