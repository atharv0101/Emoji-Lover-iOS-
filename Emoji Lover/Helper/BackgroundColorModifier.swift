import SwiftUI

// Custom aesthetic color definitions
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
        let lightOpacity = 0.4
        let darkOpacity = 0.3

        switch itemName.lowercased() {
        // Fruits
        case "apple", "cherry", "strawberry", "chilli", "tomato": color = .aestheticRed
        case "banana", "lemon", "pineapple", "giraffe": color = .aestheticYellow
        case "grapes", "onion": color = .aestheticPurple
        case "kiwi", "avocado", "broccoli": color = .aestheticGreen
        case "mango", "orange", "carrot", "fox", "lion": color = .aestheticOrange
        case "peach", "watermelon", "rabbit": color = .aestheticPink
        case "cucumber": color = .aestheticMint
        case "potato", "bear", "dog", "horse": color = .aestheticBrown
        case "garlic", "cow", "goat": color = .aestheticCream
        case "cat", "elephant", "panda": color = .aestheticGray

        // --- CORRECTED CASES FOR NUMBERS AND SHAPES ---
        // Numbers Category (each number gets a different color)
        case "one": color = .aestheticRed
        case "two": color = .aestheticOrange
        case "three": color = .aestheticYellow
        case "four": color = .aestheticGreen
        case "five": color = .aestheticSkyBlue
        case "six": color = .aestheticPurple
        case "seven": color = .aestheticPink
        case "eight": color = .aestheticMint
        case "nine": color = .aestheticBrown
        case "ten": color = .aestheticGray
        
        // Shapes Category (each shape gets a different color)
        case "circle": color = .aestheticSkyBlue
        case "square": color = .aestheticGreen
        case "triangle": color = .aestheticYellow
        case "star": color = .aestheticYellow
        case "heart": color = .aestheticRed
        case "diamond": color = .aestheticSkyBlue
            
        // Colors Category (background matches the color name)
        case "red": color = .aestheticRed
        case "yellow": color = .aestheticYellow
        case "green": color = .aestheticGreen
        case "blue": color = .aestheticSkyBlue
        case "purple": color = .aestheticPurple
        case "black": color = .aestheticGray
        case "white": color = .aestheticCream
        case "brown": color = .aestheticBrown
        // --- END OF CORRECTIONS ---
            
        // Settings Screen
        case "settings": color = .aestheticSkyBlue

        // Default fallback
        default: color = .aestheticGray
        }

        return content
            .background(color.opacity(colorScheme == .dark ? darkOpacity : lightOpacity))
            .ignoresSafeArea()
    }
}

extension View {
    func dynamicBackground(for itemName: String) -> some View {
        self.modifier(BackgroundColorModifier(itemName: itemName))
    }
}
