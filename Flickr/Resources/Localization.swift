import Foundation

enum Localization {
    // MARK: - General

    enum General {
        enum Button {
            enum Close {
                static let title: String = "Close"
            }
            enum OpenInSafari {
                static let title: String = "Open in Safari"
            }
            enum ShareLink {
                static let title: String = "Share link"
            }
        }
    }

    // MARK: - Feed View

    enum Feed {
        static let navigationTitle: String = "flickr."

        enum SearchTextField {
            static let placeholder: String = "Photos, people, or groups"
        }

        enum ContentUnavailable {
            enum Idle {
                static let title: String = "Hey there!"
                static let description: String = "You can search through the rich library of Flickr"
            }
            enum Error {
                static let title: String = "Something went wrong"
                static let description: String = "Try again later."
            }
        }

        enum Button {
            enum GridItem {
                static func a11yLabel(_ p1: String, _ p2: String) -> String { "\(p1) by \(p2)" }
                static func a11yInputLabel(_ p1: Int) -> String { "Image \(p1.formatted())" }
            }
            enum SeeDetails {
                static let title: String = "See details"
            }
        }
    }

    // MARK: - Details View

    enum Details {
        static let navigationTitle: String = "Details"

        enum Label {
            enum ID {
                static let title: String = "ID"
            }
            enum Title {
                static let title: String = "Title"
            }
            enum Author {
                static let title: String = "Author"
            }
            enum ImageSize {
                static let title: String = "Image size"
                static func value(_ p1: CGFloat, _ p2: CGFloat) -> String { "w:\(p1.formatted()), h:\(p2.formatted())" }
                static func valueA11yLabel(_ p1: CGFloat, _ p2: CGFloat) -> String { "width:\(p1.formatted()), height:\(p2.formatted())" }
            }
            enum CreationDate {
                static let title: String = "Creation date"
            }
            enum PublicationDate {
                static let title: String = "Publication date"
            }
            enum Tags {
                static let title: String = "Tags"
            }
            enum Description {
                static let title: String = "Description"
            }
        }
    }
}
