import SwiftUI

struct BackgroundColorModifier: ViewModifier {
    let itemName: String
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .background(
                getBackgroundColor(for: itemName)
                    .ignoresSafeArea()
            )
    }

    private func getBackgroundColor(for item: String) -> Color {
        switch item {
        case "Apple":
            return colorScheme == .light ? Color(red: 1.0, green: 0.85, blue: 0.85) : Color(red: 0.3, green: 0.0, blue: 0.0)
        case "Banana":
            return colorScheme == .light ? Color(red: 1.0, green: 1.0, blue: 0.7) : Color(red: 0.4, green: 0.3, blue: 0.0)
        case "Broccoli":
            return colorScheme == .light ? Color(red: 0.8, green: 1.0, blue: 0.8) : Color(red: 0.0, green: 0.3, blue: 0.0)
        case "Tiger":
            return colorScheme == .light ? Color.orange.opacity(0.3) : Color.orange.opacity(0.6)
        case "Fish":
            return colorScheme == .light ? Color.blue.opacity(0.3) : Color.blue.opacity(0.6)
        case "Grape":
            return colorScheme == .light ? Color.purple.opacity(0.2) : Color.purple.opacity(0.5)
        // Add all 36 items here...
        default:
            return colorScheme == .light ? Color.white : Color.black
        }
    }
}
extension View {
    func dynamicBackground(for item: String) -> some View {
        self.modifier(BackgroundColorModifier(itemName: item))
    }
}

