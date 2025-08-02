import SwiftUI

struct MemoryMatchView: View {
    @StateObject var viewModel = MemoryGameViewModel()
    let category: LearningCategory
    let difficulty: Difficulty
    
    @Environment(\.presentationMode) var presentationMode
    
    // Defines the grid layout based on the selected difficulty
    var columns: [GridItem] {
        switch difficulty {
        case .easy:
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        case .medium:
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        case .hard:
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        }
    }
    
    // Define padding based on difficulty to control card size
    private var gridPadding: CGFloat {
        switch difficulty {
        case .easy: return 40
        case .medium: return 40
        case .hard: return 20
        }
    }
    
    @State private var shuffledCardColors: [Color] = []
    private let cardColorPalette: [Color] = [
        .aestheticRed, .aestheticOrange, .aestheticYellow, .aestheticGreen,
        .aestheticSkyBlue, .aestheticPurple, .aestheticPink, .aestheticMint,
        .aestheticBrown, .aestheticGray
    ]

    var body: some View {
        ZStack {
            // Check if the game is over to show the correct view
            if viewModel.isGameOver {
                GameCompletionView(
                    moveCount: viewModel.moveCount,
                    starRating: viewModel.starRating,
                    onPlayAgain: {
                        // Restart the game with the same settings
                        viewModel.createMemoryGame(from: category, difficulty: difficulty)
                    },
                    onChooseAnother: {
                        // Go back to the game selection screen
                        presentationMode.wrappedValue.dismiss()
                    }
                )
                .transition(.scale.combined(with: .opacity))
                
            } else {
                // The main game board view
                VStack {
                    Text("Moves: \(viewModel.moveCount)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(viewModel.cards.indices, id: \.self) { index in
                            if !shuffledCardColors.isEmpty {
                                CardView(card: viewModel.cards[index], color: shuffledCardColors[index])
                                    .onTapGesture {
                                        SoundManager.instance.playSound(named: "flip", withExtension: "aif", volume: 0.35)
                                        HapticManager.instance.impact(style: .light)
                                        viewModel.choose(card: viewModel.cards[index])
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, gridPadding)
                    .padding(.vertical)
                }
            }
        }
        .navigationTitle(category.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Create the game state
            viewModel.createMemoryGame(from: category, difficulty: difficulty)
            
            // Create the shuffled color list
            var colors: [Color] = []
            for i in 0..<difficulty.pairCount {
                colors.append(cardColorPalette[i % cardColorPalette.count])
                colors.append(cardColorPalette[i % cardColorPalette.count])
            }
            shuffledCardColors = colors.shuffled()
            
            // Start background music when the game appears
            BackgroundMusicPlayer.instance.start()
        }
        .onDisappear {
            // Stop background music when the game disappears
            BackgroundMusicPlayer.instance.stop()
        }
        .animation(.default, value: viewModel.isGameOver)
        .onAppear{BackgroundMusicPlayer.instance.start()}
    }
}

// Defines the visual appearance and animation of a single card
struct CardView: View {
    let card: MemoryGameCard
    let color: Color
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            // This inner ZStack contains ONLY the card faces that will flip
            ZStack {
                // Card Front View
                Group {
                    let shape = RoundedRectangle(cornerRadius: 12)
                    if colorScheme == .dark {
                        shape.fill(Color(.systemGray5))
                        shape.strokeBorder(Color(.systemGray3), lineWidth: 2)
                    } else {
                        shape.fill(Color.white)
                        shape.strokeBorder(Color.gray.opacity(0.5), lineWidth: 2)
                    }
                    Text(card.content)
                        .font(.largeTitle)
                        .rotation3DEffect(.degrees(card.isFaceUp ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                }
                
                // Card Back View
                Group {
                    let shape = RoundedRectangle(cornerRadius: 12)
                    if colorScheme == .dark {
                        shape.fill(Color(white: 0.1))
                        shape.strokeBorder(Color.gray.opacity(0.5), lineWidth: 2)
                    } else {
                        shape.fill(color.gradient)
                    }
                }
                .opacity(card.isFaceUp || card.isMatched ? 0 : 1)
            }
            .rotation3DEffect(Angle.degrees(card.isFaceUp ? 180 : 0), axis: (x: 0, y: 1, z: 0))

            // Matched Overlay
            if card.isMatched {
                RoundedRectangle(cornerRadius: 12).fill(Color.black.opacity(0.4))
                Image(systemName: "checkmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.4), value: card.isFaceUp)
        .animation(.easeOut(duration: 0.3).delay(0.5), value: card.isMatched)
        .aspectRatio(2/3, contentMode: .fit)
    }
}

// A dedicated view for the game completion screen
struct GameCompletionView: View {
    let moveCount: Int
    let starRating: Int
    var onPlayAgain: () -> Void
    var onChooseAnother: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("🎉")
                .font(.system(size: 100))
            
            Text("You Won!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                ForEach(1...3, id: \.self) { star in
                    Image(systemName: star <= starRating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
                }
            }
            
            Text("You finished in \(moveCount) moves.")
                .font(.title3)
                .foregroundColor(.secondary)
            
            Spacer()
            
            VStack(spacing: 15) {
                Button(action: onPlayAgain) {
                    Text("Play Again")
                        .font(.headline).fontWeight(.bold).foregroundColor(.white).padding()
                        .frame(maxWidth: .infinity).background(Color.blue).cornerRadius(15)
                }
                .buttonStyle(SpringyButtonStyle())
                
                Button(action: onChooseAnother) {
                    Text("Choose Another Category")
                        .font(.headline).fontWeight(.semibold)
                }
            }
        }
        .padding(30)
    }
}

struct MemoryMatchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MemoryMatchView(
                category: allCategories.first!,
                difficulty: .medium
            )
        }
    }
}
