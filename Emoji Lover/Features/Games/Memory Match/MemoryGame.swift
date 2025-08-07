import Foundation

struct MemoryGameCard: Identifiable {
    let id: Int
    let content: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}

class MemoryGameViewModel: ObservableObject {
    @Published private(set) var cards: [MemoryGameCard] = []
    @Published private(set) var moveCount: Int = 0
    
    private var firstFlippedCardIndex: Int?
    private var matchStreak: Int = 0

    var isGameOver: Bool {
        !cards.isEmpty && cards.allSatisfy { $0.isMatched }
    }
    
    var starRating: Int {
        guard isGameOver else { return 0 }
        let pairCount = cards.count / 2
        if moveCount <= pairCount * 2 + 2 { return 3 }
        else if moveCount <= pairCount * 3 { return 2 }
        else { return 1 }
    }

    func createMemoryGame(from category: LearningCategory, difficulty: Difficulty) {
        let items = category.items.prefix(difficulty.pairCount)
        var gameCards: [MemoryGameCard] = []
        for (index, item) in items.enumerated() {
            gameCards.append(MemoryGameCard(id: index * 2, content: item.emoji))
            gameCards.append(MemoryGameCard(id: index * 2 + 1, content: item.emoji))
        }
        cards = gameCards.shuffled()
        moveCount = 0
        matchStreak = 0
    }
    
    func choose(card: MemoryGameCard) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIndex].isFaceUp,
              !cards[chosenIndex].isMatched
        else { return }

        if firstFlippedCardIndex != nil {
             moveCount += 1
        }

        if let potentialMatchIndex = firstFlippedCardIndex {
            cards[chosenIndex].isFaceUp = true

            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                let index1 = chosenIndex
                let index2 = potentialMatchIndex
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.cards[index1].isMatched = true
                    self.cards[index2].isMatched = true
                    
                    SoundManager.instance.playSound(named: "match", withExtension: "aif", volume: 0.7)
                    HapticManager.instance.notification(type: .success)
                    
                    self.matchStreak += 1
                    switch self.matchStreak {
                    case 2:
                        SoundManager.instance.playSound(named: "streak2", withExtension: "aif", volume: 0.8)
                    case 3:
                        SoundManager.instance.playSound(named: "streak3", withExtension: "aif", volume: 0.9)
                    case 4...:
                        SoundManager.instance.playSound(named: "streak4", withExtension: "aif", volume: 1.0)
                    default:
                        break
                    }
                    
                    if self.isGameOver {
                        SoundManager.instance.playSound(named: "win", withExtension: "aif", volume: 1.0)
                    }
                }
            } else {
                self.matchStreak = 0
                let index1 = chosenIndex
                let index2 = potentialMatchIndex
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.cards[index1].isFaceUp = false
                    self.cards[index2].isFaceUp = false
                }
            }
            firstFlippedCardIndex = nil
        
        } else {
            for index in cards.indices {
                if !cards[index].isMatched {
                    cards[index].isFaceUp = false
                }
            }
            firstFlippedCardIndex = chosenIndex
            cards[chosenIndex].isFaceUp = true
            moveCount += 1
        }
    }
}
