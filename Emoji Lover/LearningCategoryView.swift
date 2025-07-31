import SwiftUI

struct LearningCategoryView: View {
    let title: String
    let items: [LearningItem]

    @State private var shuffledItems: [LearningItem] = []
    @State private var currentIndex: Int = 0
    @State private var isSpeaking: Bool = false

    var body: some View {
        ZStack {
            // Background color applied to the whole screen
            Color.clear
                .dynamicBackground(for: shuffledItems.isEmpty ? "" : shuffledItems[currentIndex].name)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Text(title)
                    .font(.largeTitle)
                    .bold()

                if !shuffledItems.isEmpty {
                    Text(shuffledItems[currentIndex].emoji)
                        .font(.system(size: 100))

                    Text(shuffledItems[currentIndex].name)
                        .font(.title)

                    HStack(spacing: 30) {
                        Button(action: {
                            currentIndex = (currentIndex - 1 + shuffledItems.count) % shuffledItems.count
                        }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }

                        Button(action: {
                            if !isSpeaking {
                                isSpeaking = true
                                
                                // Set the completion handler on the SpeechHelper
                                SpeechHelper.shared.onSpeechDidFinish = {
                                    // This will run when the speech is finished
                                    isSpeaking = false
                                }
                                
                                // Now, call the speak function
                                SpeechHelper.shared.speak(shuffledItems[currentIndex].name)
                            }
                        }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(isSpeaking ? .gray : .accentColor) // Optional: change color while speaking
                        }
                        .disabled(isSpeaking) // Optional: disable the button while speaking

                        Button(action: {
                            currentIndex = (currentIndex + 1) % shuffledItems.count
                        }) {
                            Image(systemName: "chevron.right.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            shuffledItems = items.shuffled()
            currentIndex = 0
        }
    }
}
