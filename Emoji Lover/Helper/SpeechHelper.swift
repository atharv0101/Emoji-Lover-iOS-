import AVFoundation

class SpeechHelper: NSObject, AVSpeechSynthesizerDelegate {
    static let shared = SpeechHelper()
    private let synthesizer = AVSpeechSynthesizer()

    var isSpeaking: Bool = false
    var onSpeechDidFinish: (() -> Void)?

    private override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(_ text: String) {
        // CHANGE: Stop any currently speaking utterance immediately.
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }

        let utterance = AVSpeechUtterance(string: text)
        let settings = SpeechSettings.shared
        
        utterance.voice = AVSpeechSynthesisVoice(identifier: settings.voiceIdentifier) ?? AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = Float(settings.rate)

        isSpeaking = true
        synthesizer.speak(utterance)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
        onSpeechDidFinish?()
    }
}
