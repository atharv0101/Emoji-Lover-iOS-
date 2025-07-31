import AVFoundation

class SpeechHelper: NSObject, AVSpeechSynthesizerDelegate {
    static let shared = SpeechHelper()
    private let synthesizer = AVSpeechSynthesizer()

    var isSpeaking: Bool = false
    private var completionHandler: (() -> Void)?  // store completion

    private override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(_ text: String, completion: (() -> Void)? = nil) {
        guard !synthesizer.isSpeaking else {
            return  // prevent overlapping speech
        }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        isSpeaking = true
        completionHandler = completion  // store the closure
        synthesizer.speak(utterance)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
        completionHandler?()      // call the stored closure
        completionHandler = nil   // clear it after use
    }
}

