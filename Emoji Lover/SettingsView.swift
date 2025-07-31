import SwiftUI
import AVFoundation

struct SettingsView: View {
    @ObservedObject private var settings = SpeechSettings.shared

    var body: some View {
        ZStack {
            // Use our new custom background color
            Color.clear
                .dynamicBackground(for: "settings")
                .ignoresSafeArea()

            VStack(spacing: 40) {
                // A large, friendly title
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                // A styled container for our controls
                VStack {
                    Text("Voice")
                        .font(.headline)
                    
                    // A wheel-style picker is more fun and tactile
                    Picker("Voice", selection: $settings.voiceIdentifier) {
                        ForEach(settings.availableVoices, id: \.identifier) { voice in
                            Text(voice.name).tag(voice.identifier)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 120)
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.05))
                    .cornerRadius(20)
                }
                .padding(.horizontal)

                // Styled speed slider
                VStack {
                    Text("Speed")
                        .font(.headline)
                    Slider(
                        value: $settings.rate,
                        in: Double(AVSpeechUtteranceMinimumSpeechRate)...Double(AVSpeechUtteranceMaximumSpeechRate)
                    )
                }
                .padding(.horizontal, 40)

                Spacer()

                // A prominent, styled test button
                Button(action: {
                    SpeechHelper.shared.speak("Apple")
                }) {
                    HStack {
                        Image(systemName: "speaker.wave.2.fill")
                        Text("Test Voice")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.2), radius: 5, y: 3)
                }
                .padding()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
