import SwiftUI

private struct DIContainerKey: EnvironmentKey {
    static let defaultValue: DIContainerProtocol = DIContainer.mock()
}

extension EnvironmentValues {
    var container: DIContainerProtocol {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}
