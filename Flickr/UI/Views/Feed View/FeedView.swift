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
            ForEach(viewModel.searchResults, id: \.id) { item in
                gridItemView(for: item)
            }
        }
    }

    @ViewBuilder @MainActor
    private func gridItemView(for item: FeedItem) -> some View {
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
            }
        )
        .buttonStyle(.plain)
        .contextMenu {
            if !item.title.isEmpty {
                Text(item.title)
                Divider()
            }

            Button(Localized.Button.SeeDetails.title, systemImage: "list.bullet.rectangle") {
                viewModel.selectItem(item)
            }

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
        } preview: {
            RemoteImageView(
                viewModel: RemoteImageViewModel(
                    container: container,
                    mediaURL: item.mediaURL,
                    transaction: Transaction(animation: .none)
                )
            )
        }
    }
}

#Preview {
    FeedView(viewModel: FeedViewModel(container: DIContainer.mock()))
}
