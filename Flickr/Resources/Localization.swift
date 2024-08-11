import SwiftUI

enum Localization {
    // MARK: - General

    enum General {
        enum Button {
            enum Done {
                static let title: LocalizedStringKey = "Done"
            }
            enum OpenInSafari {
                static let title: LocalizedStringKey = "Open in Safari"
            }
            enum ShareLink {
                static let title: LocalizedStringKey = "Share link"
            }
        }
    }

    // MARK: - Feed View

    enum Feed {
        static let navigationTitle: LocalizedStringKey = "flickr."

        enum SearchTextField {
            static let placeholder: LocalizedStringKey = "Photos, people, or groups"
        }

        enum ContentUnavailable {
            enum Idle {
                static let title: LocalizedStringKey = "Hey there!"
                static let description: LocalizedStringKey = "You can search through the rich library of Flickr"
            }
            enum Error {
                static let title: LocalizedStringKey = "Something went wrong"
                static let description: LocalizedStringKey = "Try again later."
            }
        }

        enum Button {
            enum SeeDetails {
                static let title: LocalizedStringKey = "See details"
            }
        }
    }

    // MARK: - Details View

    enum Details {
        static let navigationTitle: LocalizedStringKey = "Details"

        enum Label {
            enum ID {
                static let title: LocalizedStringKey = "ID"
            }
            enum Title {
                static let title: LocalizedStringKey = "Title"
            }
            enum Author {
                static let title: LocalizedStringKey = "Author"
            }
            enum ImageSize {
                static let title: LocalizedStringKey = "Image size"
                static func value(_ p1: CGFloat, _ p2: CGFloat) -> LocalizedStringKey { "w:\(p1), h:\(p2)" }
            }
            enum CreationDate {
                static let title: LocalizedStringKey = "Creation date"
            }
            enum PublicationDate {
                static let title: LocalizedStringKey = "Publication date"
            }
            enum Tags {
                static let title: LocalizedStringKey = "Tags"
            }
            enum Description {
                static let title: LocalizedStringKey = "Description"
            }
        }
    }
}
