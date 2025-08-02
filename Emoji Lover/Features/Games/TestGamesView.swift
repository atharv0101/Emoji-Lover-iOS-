import SwiftUI

struct TestGamesView: View {
    @State private var isShowingSetupSheet = false
    @State private var gameToStart: (category: LearningCategory, difficulty: Difficulty)? = nil
    
    // --- FIX: Add a state to control the navigation link ---
    @State private var isGameActive = false

    let columns: [GridItem] = [ GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20) ]

    var body: some View {
        NavigationView {
            ZStack {
                // --- FIX: Correctly set up the programmatic NavigationLink ---
                if let gameInfo = gameToStart {
                    NavigationLink(
                        destination: MemoryMatchView(category: gameInfo.category, difficulty: gameInfo.difficulty),
                        isActive: $isGameActive,
                        label: { EmptyView() }
                    )
                }

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(allGames) { game in
                            if game.title == "Memory Match" {
                                Button(action: { isShowingSetupSheet = true }) {
                                    GameCardView(icon: game.icon, title: game.title)
                                }
                                .buttonStyle(GrowButtonStyle())
                            } else {
                                NavigationLink(destination: Text("\(game.title) - Coming Soon!")) {
                                    GameCardView(icon: game.icon, title: game.title)
                                }
                                .buttonStyle(GrowButtonStyle())
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Test Your Skills")
            }
        }
        .navigationViewStyle(.stack)
        .customPopup(isPresented: $isShowingSetupSheet) {
            MemoryMatchSetupView(onStartGame: { category, difficulty in
                isShowingSetupSheet = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    gameToStart = (category, difficulty)
                    // --- FIX: Trigger the navigation ---
                    isGameActive = true
                }
            })
            .frame(width: 400, height: 450)
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
