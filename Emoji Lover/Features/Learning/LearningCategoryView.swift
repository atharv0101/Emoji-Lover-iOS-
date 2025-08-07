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
                if value.translation.width < -50 { handleNext() }
                else if value.translation.width > 50 { handlePrevious() }
            }
    }

    var body: some View {
        ZStack {
            Color.clear
                .dynamicBackground(for: shuffledItems.isEmpty ? "" : shuffledItems[currentIndex].name)
                .ignoresSafeArea()
                .contentShape(Rectangle())
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
                VStack(spacing: 20) {
                    // The old ProgressBar view that was here has been REMOVED.
                    Spacer()
                    
                    Text(title).font(.headline).foregroundColor(.secondary)
                    
                    VStack(spacing: 15) {
                        Text(shuffledItems.isEmpty ? "" : shuffledItems[currentIndex].emoji)
                            .font(.system(size: 120))
                        
                        Text(shuffledItems.isEmpty ? "" : shuffledItems[currentIndex].name)
                            .font(.system(size: 44, weight: .bold))
                        
                        // --- NEW: The page indicator dots are now here ---
                        if !shuffledItems.isEmpty {
                            PageIndicatorView(pageCount: shuffledItems.count, currentPage: currentIndex)
                                .padding(.top)
                        }
                    }
                    .transition(.asymmetric(
                        insertion: .move(edge: transitionEdge),
                        removal: .move(edge: transitionEdge == .trailing ? .leading : .trailing)
                    ).combined(with: .opacity))
                    .id(shuffledItems.isEmpty ? UUID() : shuffledItems[currentIndex].id)
                    
                    Spacer()
                    
                    Button(action: {
                        if !isSpeaking, !shuffledItems.isEmpty {
                            isSpeaking = true
                            SpeechHelper.shared.onSpeechDidFinish = { isSpeaking = false }
                            SpeechHelper.shared.speak(shuffledItems[currentIndex].name)
                        }
                    }) {
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.largeTitle).padding().background(Color.primary.opacity(0.1))
                            .clipShape(Circle()).foregroundColor(isSpeaking ? .gray : .accentColor)
                    }
                    .disabled(isSpeaking).buttonStyle(SpringyButtonStyle()).padding(.bottom)
                }
                .padding()
            }
            
            // Custom Back Button Overlay
            VStack {
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2.weight(.bold)).foregroundColor(.primary)
                            .padding().background(.thinMaterial).clipShape(Circle())
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onAppear { shuffledItems = items.shuffled() }
        .toolbar(.hidden, for: .tabBar)
    }
    
    func handleNext() {
        self.transitionEdge = .trailing
        withAnimation(.easeInOut(duration: 0.4)) {
            if currentIndex < shuffledItems.count - 1 { currentIndex += 1 }
            else { isCompleted = true }
        }
    }
    
    func handlePrevious() {
        self.transitionEdge = .leading
        withAnimation(.easeInOut(duration: 0.4)) {
            if currentIndex > 0 { currentIndex -= 1 }
        }
    }
}

// --- NEW: A view for the page indicator dots ---
struct PageIndicatorView: View {
    let pageCount: Int
    let currentPage: Int

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<pageCount, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color.accentColor : Color.primary.opacity(0.2))
                    .frame(width: 8, height: 8)
                    .scaleEffect(index == currentPage ? 1.2 : 1.0)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: currentPage)
    }
}


// The old ProgressBar struct has been DELETED.
// CompletionView and SpringyButtonStyle structs remain the same.

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
