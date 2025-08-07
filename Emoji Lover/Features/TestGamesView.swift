import SwiftUI

struct TestGamesView: View {
    // State for Memory Match game flow
    @State private var isShowingMemorySetup = false
    @State private var memoryGameToStart: (category: LearningCategory, difficulty: Difficulty)? = nil
    @State private var isMemoryGameActive = false
    
    // State for Find The Emoji game flow
    @State private var isShowingFindTheEmojiSetup = false
    @State private var findTheEmojiGameToStart: (category: LearningCategory, difficulty: Difficulty)? = nil
    @State private var isFindTheEmojiGameActive = false

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // --- Hidden NavigationLinks for both games ---
                Group {
                    // Hidden link for Memory Match
                    if let gameInfo = memoryGameToStart {
                        NavigationLink(
                            destination: MemoryMatchView(category: gameInfo.category, difficulty: gameInfo.difficulty),
                            isActive: $isMemoryGameActive,
                            label: { EmptyView() }
                        )
                    }
                    
                    // Hidden link for Find The Emoji
                    if let gameInfo = findTheEmojiGameToStart {
                        NavigationLink(
                            destination: FindTheEmojiView(category: gameInfo.category, difficulty: gameInfo.difficulty),
                            isActive: $isFindTheEmojiGameActive,
                            label: { EmptyView() }
                        )
                    }
                }

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(allGames) { game in
                            Button(action: {
                                // This button now handles both games
                                if game.title == "Memory Match" {
                                    isShowingMemorySetup = true
                                } else if game.title == "Find The Emoji" {
                                    isShowingFindTheEmojiSetup = true
                                }
                            }) {
                                GameCardView(icon: game.icon, title: game.title)
                            }
                            .buttonStyle(GrowButtonStyle())
                        }
                    }
                    .padding()
                }
                .navigationTitle("Test Your Skills")
            }
        }
        .navigationViewStyle(.stack)
        // Pop-up for Memory Match
        .customPopup(isPresented: $isShowingMemorySetup) {
            MemoryMatchSetupView(onStartGame: { category, difficulty in
                isShowingMemorySetup = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    memoryGameToStart = (category, difficulty)
                    isMemoryGameActive = true
                }
            })
            .frame(width: 400, height: 520)
        }
        // Pop-up for Find The Emoji
        .customPopup(isPresented: $isShowingFindTheEmojiSetup) {
            // We reuse the same setup view!
            MemoryMatchSetupView(onStartGame: { category, difficulty in
                isShowingFindTheEmojiSetup = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    findTheEmojiGameToStart = (category, difficulty)
                    isFindTheEmojiGameActive = true
                }
            })
            .frame(width: 400, height: 520)
        }
    }
}

// Helper view for the game cards
struct GameCardView: View {
    let icon: String
    let title: String
    var body: some View {
        VStack(spacing: 15) {
            Text(icon).font(.system(size: 60))
            Text(title).font(.headline).fontWeight(.bold).foregroundColor(.primary)
        }
        .padding().frame(maxWidth: .infinity, minHeight: 150)
        .background(Color.primary.opacity(0.05)).cornerRadius(20)
    }
}

struct TestGamesView_Previews: PreviewProvider {
    static var previews: some View {
        TestGamesView()
    }
}
