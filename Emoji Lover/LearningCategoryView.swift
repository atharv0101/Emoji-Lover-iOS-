import SwiftUI
import AVFoundation

struct LearningCategoryView: View {
    let title: String
    let items: [LearningItem]
    @State private var currentIndex = 0
    @State private var isSpeaking = false


    var body: some View {
        VStack(spacing: 30) {
            Text(items[currentIndex].emoji)
                .font(.system(size: 150))

            Text(items[currentIndex].name)
                .font(.largeTitle)
                .bold()

            Button("🔊 Speak") {
                isSpeaking = true
                SpeechHelper.shared.onSpeechDidFinish = {
                    isSpeaking = false
                }
                SpeechHelper.shared.speak(items[currentIndex].name)
            }
            .disabled(isSpeaking)  // disables button while speaking
            .opacity(isSpeaking ? 0.5 : 1.0)  // visual feedback



            HStack {
                Button("◀️") {
                    if currentIndex > 0 {
                        currentIndex -= 1
                    }
                }

                Button("▶️") {
                    if currentIndex < items.count - 1 {
                        currentIndex += 1
                    }
                }
            }
        }
        .padding()
    }
}

