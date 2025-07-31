import AVFoundation

class SpeechHelper: NSObject, AVSpeechSynthesizerDelegate {
    static let shared = SpeechHelper()
    private let synthesizer = AVSpeechSynthesizer()

    var isSpeaking: Bool = false
    var onSpeechDidFinish: (() -> Void)?  // callback

    private override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(_ text: String) {
        guard !synthesizer.isSpeaking else {
            return  // prevent overlapping speech
        }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        isSpeaking = true
        synthesizer.speak(utterance)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
        onSpeechDidFinish?()
    }
}

