import SwiftUI

struct LearningCategoryView: View {
    let title: String
    let items: [LearningItem]

    @State private var shuffledItems: [LearningItem] = []
    @State private var currentIndex: Int = 0
    @State private var isSpeaking: Bool = false
    @State private var transitionEdge: Edge = .trailing
    
    // State to track if the category is completed.
    @State private var isCompleted: Bool = false
    
    // Environment variable to allow us to dismiss this screen.
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            // Background color updates based on the current item.
            Color.clear
                .dynamicBackground(for: shuffledItems.isEmpty ? "" : shuffledItems[currentIndex].name)
                .ignoresSafeArea()
            
            // We now show a different view if the category is completed.
            if isCompleted {
                CompletionView {
                    // Action for "Learn Again" button
                    withAnimation {
                        shuffledItems = items.shuffled()
                        isCompleted = false
                        currentIndex = 0
                    }
                } onChooseAnother: {
                    // Action for "Choose Another" button
                    presentationMode.wrappedValue.dismiss()
                }
                .transition(.scale.combined(with: .opacity))

            } else {
                // This is the normal learning view.
                VStack(spacing: 20) {
                    if !shuffledItems.isEmpty {
                        ProgressBar(currentValue: currentIndex + 1, totalValue: shuffledItems.count)
                    }

                    Spacer()

                    Text(title)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    VStack(spacing: 15) {
                        Text(shuffledItems.isEmpty ? "" : shuffledItems[currentIndex].emoji)
                            .font(.system(size: 120))

                        Text(shuffledItems.isEmpty ? "" : shuffledItems[currentIndex].name)
                            .font(.system(size: 44, weight: .bold))
                    }
                    .transition(.asymmetric(
                        insertion: .move(edge: transitionEdge),
                        removal: .move(edge: transitionEdge == .trailing ? .leading : .trailing)
                    ).combined(with: .opacity))
                    .id(shuffledItems.isEmpty ? UUID() : shuffledItems[currentIndex].id)

                    Spacer()

                    HStack(spacing: 30) {
                        // Left Button
                        Button(action: {
                            self.transitionEdge = .leading
                            withAnimation(.easeInOut(duration: 0.4)) {
                                if currentIndex > 0 { currentIndex -= 1 }
                            }
                        }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .resizable().frame(width: 50, height: 50)
                        }
                        .buttonStyle(SpringyButtonStyle())
                        .disabled(currentIndex == 0)

                        // Speaker Button
                        Button(action: {
                            if !isSpeaking {
                                isSpeaking = true
                                SpeechHelper.shared.onSpeechDidFinish = { isSpeaking = false }
                                SpeechHelper.shared.speak(shuffledItems[currentIndex].name)
                            }
                        }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(isSpeaking ? .gray : .accentColor)
                        }
                        .disabled(isSpeaking)
                        .buttonStyle(SpringyButtonStyle())

                        // Right Button
                        Button(action: {
                            self.transitionEdge = .trailing
                            withAnimation(.easeInOut(duration: 0.4)) {
                                // Instead of looping, we check if we're at the end.
                                if currentIndex < shuffledItems.count - 1 {
                                    currentIndex += 1
                                } else {
                                    // If we are at the end, trigger the completion state.
                                    isCompleted = true
                                }
                            }
                        }) {
                            Image(systemName: "chevron.right.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(SpringyButtonStyle())
                    }
                }
                .padding()
            }
        }
        .onAppear {
            shuffledItems = items.shuffled()
        }
    }
}

// A new, reusable view for our progress bar.
struct ProgressBar: View {
    let currentValue: Int
    let totalValue: Int

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // The background of the bar
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(.primary.opacity(0.1))
                
                // The filled portion of the bar
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(Color.accentColor)
                    .frame(width: geometry.size.width * (CGFloat(currentValue) / CGFloat(totalValue)))
            }
        }
        .frame(height: 12)
        .animation(.spring(), value: currentValue)
        .padding(.horizontal)
    }
}

// A brand new view for the completion screen.
struct CompletionView: View {
    var onLearnAgain: () -> Void
    var onChooseAnother: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Text("🏆")
                .font(.system(size: 120))
            
            Text("Category Completed!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Great job!")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Spacer()
            
            // Button to restart the current category
            Button(action: onLearnAgain) {
                Text("Learn Again")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            .buttonStyle(SpringyButtonStyle())
            
            // Button to go back to the category grid
            Button(action: onChooseAnother) {
                Text("Choose Another Category")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .padding(.bottom)
        }
        .padding()
    }
}
