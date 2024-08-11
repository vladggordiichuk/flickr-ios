import SwiftUI
import Combine

@MainActor @Observable
final class FeedViewModel {
    // MARK: - Parameters

    private(set) var state: DataLoadState = .idle
    var searchQuery: String = .init() { didSet { searchQueryPublisher.send(searchQuery) } }
    private(set) var searchResults: [FeedItem] = []
    var selectedItem: FeedItem?

    @ObservationIgnored
    private var container: DIContainerProtocol
    @ObservationIgnored
    private var searchQueryPublisher: PassthroughSubject<String, Never> = .init()
    @ObservationIgnored
    private var searchQueryPublisherDebounce: Double
    @ObservationIgnored
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    init(
        container: DIContainerProtocol,
        searchQueryPublisherDebounceFor debounce: Double = 0.5
    ) {
        self.container = container
        self.searchQueryPublisherDebounce = debounce

        setUpBinders()
    }

    // MARK: - Binders

    private func setUpBinders() {
        bindSearchQuery()
    }

    private func bindSearchQuery() {
        searchQueryPublisher
            .removeDuplicates()
            .map { $0.count > 2 }
            .sink { [weak self] isValidQuery in
                self?.state = isValidQuery ? .loading : .idle
            }
            .store(in: &cancellables)

        searchQueryPublisher
            .removeDuplicates()
            .debounce(
                for: .init(searchQueryPublisherDebounce),
                scheduler: RunLoop.main
            )
            .filter { $0.count > 2 }
            .print()
            .compactMap { [weak self] in
                return self?.container.networkService.fetchPublicFeedPublisher(with: $0)
                    .catch { [weak self] _ in
                        self?.state = .error
                        return Empty<[FeedItem], Never>().eraseToAnyPublisher()
                    }
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] feedItems in
                self?.state = .loaded
                self?.searchResults = feedItems
            }
            .store(in: &cancellables)
    }

    // MARK: - Interaction Method

    func selectItem(_ item: FeedItem) {
        selectedItem = item
    }
}
