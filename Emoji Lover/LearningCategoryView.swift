import SwiftUI
import AVFoundation

struct LearningCategoryView: View {
    let title: String
    let items: [LearningItem]
    @State private var currentIndex = 0

    var body: some View {
        VStack(spacing: 30) {
            Text(items[currentIndex].emoji)
                .font(.system(size: 150))

            Text(items[currentIndex].name)
                .font(.largeTitle)
                .bold()

            Button("🔊 Speak") {
                let utterance = AVSpeechUtterance(string: items[currentIndex].name)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                AVSpeechSynthesizer().speak(utterance)
            }

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

