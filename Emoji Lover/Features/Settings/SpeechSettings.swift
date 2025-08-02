import Foundation
import AVFoundation
import SwiftUI

class SpeechSettings: ObservableObject {
    @AppStorage("speechVoiceIdentifier") var voiceIdentifier: String = ""
    @AppStorage("speechRateValue") var rate: Double = Double(AVSpeechUtteranceDefaultSpeechRate)

    static let shared = SpeechSettings()
    let availableVoices: [AVSpeechSynthesisVoice]

    private init() {
        // 1. Define the list of specific voice names to include.
        let preferredVoiceNames = ["Samantha", "Rishi", "Good News"]

        // 2. Filter system voices to include our list PLUS any Siri voices.
        self.availableVoices = AVSpeechSynthesisVoice.speechVoices().filter { voice in
            return preferredVoiceNames.contains(voice.name) || voice.name.contains("Siri")
        }.sorted { $0.name < $1.name } // Sort them alphabetically.

        
        // 3. Set the default preference order: Siri > Samantha > Rishi > etc.
        let defaultIdentifier: String
        
        if let siriVoice = self.availableVoices.first(where: { $0.name.contains("Siri") }) {
            defaultIdentifier = siriVoice.identifier // Prefer Siri first
        } else if let samanthaVoice = self.availableVoices.first(where: { $0.name == "Samantha" }) {
            defaultIdentifier = samanthaVoice.identifier // Then Samantha
        } else if let rishiVoice = self.availableVoices.first(where: { $0.name == "Rishi" }) {
            defaultIdentifier = rishiVoice.identifier // Then Rishi
        } else {
            defaultIdentifier = self.availableVoices.first?.identifier ?? "" // Then whatever is left
        }

        // 4. If the user hasn't chosen a voice yet, or their old choice is now invalid,
        // set our new smart default.
        if voiceIdentifier.isEmpty || !self.availableVoices.contains(where: { $0.identifier == voiceIdentifier }) {
            self.voiceIdentifier = defaultIdentifier
        }
    }
}
