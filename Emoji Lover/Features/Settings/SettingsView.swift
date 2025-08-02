import SwiftUI
import AVFoundation

struct SettingsView: View {
    @ObservedObject private var settings = SpeechSettings.shared
    
    // --- NEW: A saved setting for the background music ---
    @AppStorage("isMusicEnabled") private var isMusicEnabled: Bool = true

    var body: some View {
        ZStack {
            Color.clear.dynamicBackground(for: "settings").ignoresSafeArea()

            VStack(spacing: 40) {
                Text("Settings").font(.largeTitle).fontWeight(.bold).padding(.top)

                VStack {
                    Text("Voice").font(.headline)
                    Picker("Voice", selection: $settings.voiceIdentifier) {
                        ForEach(settings.availableVoices, id: \.identifier) { voice in
                            Text(voice.name).tag(voice.identifier)
                        }
                    }
                    .pickerStyle(.wheel).frame(height: 120).padding(.horizontal)
                    .background(Color.primary.opacity(0.05)).cornerRadius(20)
                }
                .padding(.horizontal)

                VStack {
                    Text("Speed").font(.headline)
                    Slider(
                        value: $settings.rate,
                        in: Double(AVSpeechUtteranceMinimumSpeechRate)...Double(AVSpeechUtteranceMaximumSpeechRate)
                    )
                }
                .padding(.horizontal, 40)
                
                // --- NEW: Toggle switch for background music ---
                Toggle(isOn: $isMusicEnabled) {
                    Text("Background Music")
                        .font(.headline)
                }
                .padding()
                .background(Color.primary.opacity(0.05))
                .cornerRadius(20)
                .padding(.horizontal)
                .onChange(of: isMusicEnabled) { _ in
                    // When the toggle changes, tell the music player
                    BackgroundMusicPlayer.instance.toggle()
                }

                Spacer()

                Button(action: { SpeechHelper.shared.speak("Apple") }) {
                    HStack {
                        Image(systemName: "speaker.wave.2.fill")
                        Text("Test Voice")
                    }
                    .font(.headline).foregroundColor(.white).padding()
                    .frame(maxWidth: .infinity).background(Color.blue).cornerRadius(15)
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
