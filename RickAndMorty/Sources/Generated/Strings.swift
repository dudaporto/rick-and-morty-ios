// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum CharacterList {
    /// Which character are you looking for?
    internal static let searchBarPlaceholder = Strings.tr("Localizable", "characterList.searchBarPlaceholder", fallback: "Which character are you looking for?")
    /// Search for Rick & Morty character by name
    internal static let subtitle = Strings.tr("Localizable", "characterList.subtitle", fallback: "Search for Rick & Morty character by name")
    /// Characters
    internal static let title = Strings.tr("Localizable", "characterList.title", fallback: "Characters")
    internal enum CharacterCell {
      /// Last known location
      internal static let lastKnownLocation = Strings.tr("Localizable", "characterList.characterCell.lastKnownLocation", fallback: "Last known location")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
