import SwiftUI

struct FindTheEmojiView: View {
    @StateObject var viewModel = FindTheEmojiViewModel()
    
    let category: LearningCategory
    let difficulty: Difficulty
    
    @Environment(\.presentationMode) var presentationMode
    
    var columns: [GridItem] {
        switch difficulty {
        case .easy, .medium:
            return [GridItem(.flexible()), GridItem(.flexible())]
        case .hard:
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        }
    }

    var body: some View {
        ZStack {
            if viewModel.isGameOver {
                GameCompletionView(
                    moveCount: viewModel.score,
                    starRating: viewModel.starRating,
                    onPlayAgain: {
                        viewModel.createGame(from: category, difficulty: difficulty)
                    },
                    onChooseAnother: {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
                .transition(.scale.combined(with: .opacity))
                
            } else {
                VStack(spacing: 30) {
                    // --- FIX: Ensure a question exists before trying to display it ---
                    if let question = viewModel.currentQuestion {
                        HStack {
                            ForEach(0..<viewModel.questions.count, id: \.self) { index in
                                Circle()
                                    .fill(dotColor(for: index))
                                    .frame(width: 10, height: 10)
                            }
                        }
                        
                        VStack {
                            Text("Find the...")
                                .font(.largeTitle).fontWeight(.semibold).foregroundColor(.secondary)
                            
                            Button(action: {
                                SpeechHelper.shared.speak(question.correctAnswer.name)
                            }) {
                                HStack {
                                    Image(systemName: "speaker.wave.2.fill")
                                    Text(question.correctAnswer.name)
                                }
                                .font(.title.weight(.bold)).foregroundColor(.primary)
                            }
                        }
                        .padding()

                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(question.options) { item in
                                Button(action: {
                                    viewModel.submitAnswer(for: item)
                                }) {
                                    Text(item.emoji)
                                        .font(.system(size: 80))
                                        .frame(maxWidth: .infinity, minHeight: 150)
                                        .background(Color.primary.opacity(0.05))
                                        .cornerRadius(20)
                                }
                                .buttonStyle(SpringyButtonStyle())
                            }
                        }
                    } else {
                         // Shows a loading state or if there was an error creating the game
                        Text("Getting questions ready...")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Find the Emoji")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.createGame(from: category, difficulty: difficulty)
        }
        .animation(.default, value: viewModel.currentQuestionIndex)
        .toolbar(.hidden, for: .tabBar)
    }
    
    private func dotColor(for index: Int) -> Color {
        if index >= viewModel.questionResults.count {
            return .gray.opacity(0.3)
        }
        return viewModel.questionResults[index] ? .green : .red
    }
}
// Preview Provider
struct FindTheEmojiView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FindTheEmojiView(
                category: allCategories.first!,
                difficulty: .medium
            )
        }
    }
}
