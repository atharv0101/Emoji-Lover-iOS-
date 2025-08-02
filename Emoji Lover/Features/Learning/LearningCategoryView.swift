import SwiftUI

struct LearningCategoryView: View {
    let title: String
    let items: [LearningItem]

    @State private var shuffledItems: [LearningItem] = []
    @State private var currentIndex: Int = 0
    @State private var isSpeaking: Bool = false
    @State private var transitionEdge: Edge = .trailing
    @State private var isCompleted: Bool = false
    
    @Environment(\.presentationMode) var presentationMode

    var dragGesture: some Gesture {
        DragGesture()
            .onEnded { value in
                if value.translation.width < -50 {
                    handleNext()
                } else if value.translation.width > 50 {
                    handlePrevious()
                }
            }
    }

    var body: some View {
        ZStack {
            // CHANGE: The gesture is now attached to the background view
            // which covers the entire screen.
            Color.clear
                .dynamicBackground(for: shuffledItems.isEmpty ? "" : shuffledItems[currentIndex].name)
                .ignoresSafeArea()
                .contentShape(Rectangle()) // Ensures the whole area is interactive
                .gesture(dragGesture)

            if isCompleted {
                CompletionView {
                    withAnimation {
                        shuffledItems = items.shuffled()
                        isCompleted = false
                        currentIndex = 0
                    }
                } onChooseAnother: {
                    presentationMode.wrappedValue.dismiss()
                }
                .transition(.scale.combined(with: .opacity))

            } else {
                // The VStack no longer has the gesture attached.
                // We use .allowsHitTesting(false) so that empty parts of the VStack
                // don't block the gesture from reaching the background.
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

                    // The button will still be tappable because it's a specific control.
                    Button(action: {
                        if !isSpeaking, !shuffledItems.isEmpty {
                            isSpeaking = true
                            SpeechHelper.shared.onSpeechDidFinish = { isSpeaking = false }
                            SpeechHelper.shared.speak(shuffledItems[currentIndex].name)
                        }
                    }) {
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.primary.opacity(0.1))
                            .clipShape(Circle())
                            .foregroundColor(isSpeaking ? .gray : .accentColor)
                    }
                    .disabled(isSpeaking)
                    .buttonStyle(SpringyButtonStyle())
                    .padding(.bottom)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .onAppear {
            shuffledItems = items.shuffled()
        }
    }
    
    func handleNext() {
        self.transitionEdge = .trailing
        withAnimation(.easeInOut(duration: 0.4)) {
            if currentIndex < shuffledItems.count - 1 {
                currentIndex += 1
            } else {
                isCompleted = true
            }
        }
    }
    
    func handlePrevious() {
        self.transitionEdge = .leading
        withAnimation(.easeInOut(duration: 0.4)) {
            if currentIndex > 0 {
                currentIndex -= 1
            }
        }
    }
}

// Helper Views
// These should be in their own files as we discussed.

struct ProgressBar: View {
    let currentValue: Int
    let totalValue: Int
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 6).foregroundColor(.primary.opacity(0.1))
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

struct CompletionView: View {
    var onLearnAgain: () -> Void
    var onChooseAnother: () -> Void
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Text("🏆").font(.system(size: 120))
            Text("Category Completed!").font(.largeTitle).fontWeight(.bold)
            Text("Great job!").font(.title2).foregroundColor(.secondary)
            Spacer()
            Button(action: onLearnAgain) {
                Text("Learn Again")
                    .font(.headline).fontWeight(.bold).foregroundColor(.white).padding()
                    .frame(maxWidth: .infinity).background(Color.blue).cornerRadius(15)
            }
            .buttonStyle(SpringyButtonStyle())
            Button(action: onChooseAnother) {
                Text("Choose Another Category").font(.headline).fontWeight(.semibold)
            }
            .padding(.bottom)
        }
        .padding()
    }
}
