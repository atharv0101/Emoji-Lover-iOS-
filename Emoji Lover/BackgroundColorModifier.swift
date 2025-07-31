import SwiftUI

extension Color {
    static let aestheticRed = Color(red: 255/255, green: 121/255, blue: 121/255)
    static let aestheticYellow = Color(red: 253/255, green: 225/255, blue: 139/255)
    static let aestheticPurple = Color(red: 199/255, green: 177/255, blue: 255/255)
    static let aestheticGreen = Color(red: 177/255, green: 226/255, blue: 164/255)
    static let aestheticOrange = Color(red: 255/255, green: 179/255, blue: 130/255)
    static let aestheticPink = Color(red: 255/255, green: 192/255, blue: 203/255)
    static let aestheticMint = Color(red: 181/255, green: 234/255, blue: 215/255)
    static let aestheticBrown = Color(red: 210/255, green: 180/255, blue: 140/255)
    static let aestheticCream = Color(red: 245/255, green: 245/255, blue: 220/255)
    static let aestheticSkyBlue = Color(red: 135/255, green: 206/255, blue: 235/255)
    static let aestheticGray = Color(red: 211/255, green: 211/255, blue: 211/255)
}


struct BackgroundColorModifier: ViewModifier {
    var itemName: String
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        let color: Color

        // Light mode uses a brighter, more opaque shade.
        // Dark mode uses a softer, warmer, and more transparent shade.
        let lightOpacity = 0.4
        let darkOpacity = 0.3

        switch itemName.lowercased() {
        // Fruits
        case "apple": color = .aestheticRed
        case "banana": color = .aestheticYellow
        case "cherry": color = .aestheticRed
        case "grapes": color = .aestheticPurple
        case "kiwi": color = .aestheticGreen
        case "lemon": color = .aestheticYellow
        case "mango": color = .aestheticOrange
        case "orange": color = .aestheticOrange
        case "peach": color = .aestheticPink
        case "pineapple": color = .aestheticYellow
        case "strawberry": color = .aestheticRed
        case "watermelon": color = .aestheticPink

        // Vegetables
        case "avocado": color = .aestheticGreen
        case "broccoli": color = .aestheticGreen
        case "carrot": color = .aestheticOrange
        case "chilli": color = .aestheticRed
        case "cucumber": color = .aestheticMint
        case "garlic": color = .aestheticCream
        case "onion": color = .aestheticPurple
        case "potato": color = .aestheticBrown
        case "tomato": color = .aestheticRed

        // Animals
        case "bear": color = .aestheticBrown
        case "cat": color = .aestheticGray
        case "cow": color = .aestheticCream
        case "dog": color = .aestheticBrown
        case "elephant": color = .aestheticGray
        case "fox": color = .aestheticOrange
        case "goat": color = .aestheticCream
        case "giraffe": color = .aestheticYellow
        case "horse": color = .aestheticBrown
        case "lion": color = .aestheticOrange
        case "panda": color = .aestheticGray
        case "rabbit": color = .aestheticPink
            
        // Settings Screen
        case "settings": color = .aestheticSkyBlue

        // Default fallback
        default: color = .aestheticGray
        }

        return content
            .background(color.opacity(colorScheme == .dark ? darkOpacity : lightOpacity))
            .ignoresSafeArea()
    }

    // This function is unused and can be safely removed if you like.
    func colorForItem(name: String) -> Color {
        switch name.lowercased() {
        case "apple", "banana", "cherry":
            return .red
        case "carrot", "broccoli", "spinach":
            return .green
        case "lion", "tiger", "elephant":
            return .orange
        default:
            return .gray
        }
    }
}

// This extension lets you write .dynamicBackground(for: "Apple")
extension View {
    func dynamicBackground(for itemName: String) -> some View {
        self.modifier(BackgroundColorModifier(itemName: itemName))
    }
}
