import Foundation
public struct SFTheme: Codable {
    let onPrimary: String
    let onPrimaryContainer: String
    let primary: String
    let primaryContainer: String
    let secondary: String
    let secondaryContainer: String
    let primaryVariant: String
    let onSecondary: String
    let secondaryActive: String
    let secondaryHighlight: String
    let onSecondaryVariant: String
    let background: String
    let onBackground: String
    let surface: String

    let navigationBackground: String
    let navigationText: String
    let navigationInvertedBackground: String
    let navigationInvertedText: String
    
    enum CodingKeys: String, CodingKey {
        case onPrimary = "SMI.onPrimary"
        case onPrimaryContainer = "SMI.onPrimaryContainer"
        case primary = "SMI.primary"
        case primaryContainer = "SMI.primaryContainer"
        case secondary = "SMI.secondary"
        case secondaryContainer = "SMI.secondaryContainer"
        case primaryVariant = "SMI.primaryVariant"
        case onSecondary = "SMI.onSecondary"
        case secondaryActive = "SMI.secondaryActive"
        case secondaryHighlight = "SMI.secondaryHighlight"
        case onSecondaryVariant = "SMI.onSecondaryVariant"
        case background = "SMI.background"
        case onBackground = "SMI.onBackground"
        case surface = "SMI.surface"

        case navigationBackground = "SMI.navigationBackground"
        case navigationText = "SMI.navigationText"
        case navigationInvertedBackground = "SMI.navigationInvertedBackground"
        case navigationInvertedText = "SMI.navigationInvertedText"
    }
}
