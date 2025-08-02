import Foundation
enum Difficulty: String, CaseIterable, Identifiable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var id: String { self.rawValue }
    
    // Define how many pairs of cards each difficulty has
    var pairCount: Int {
        switch self {
        case .easy: return 4 // 8 cards total
        case .medium: return 6 // 12 cards total
        case .hard: return 10 // 20 cards total
        }
    }
}
// A structure to define a game
struct TestGame: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let description: String
}

// A list of all the games we will build
let allGames: [TestGame] = [
    TestGame(title: "Memory Match", icon: "🧠", description: "Find all the matching pairs."),
    TestGame(title: "Find The Emoji", icon: "🔍", description: "Listen to the word and find the correct emoji.")
]
