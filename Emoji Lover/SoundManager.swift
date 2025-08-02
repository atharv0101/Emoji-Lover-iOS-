import AVFoundation

class SoundManager {
    static let instance = SoundManager()
    var audioPlayer: AVAudioPlayer?

    // --- CHANGE: Add a 'volume' parameter with a default of 1.0 ---
    func playSound(named soundName: String, withExtension ext: String = "mp3", volume: Float = 1.0) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: ext) else {
            print("Error: Sound file '\(soundName).\(ext)' not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            // --- CHANGE: Set the volume on the audio player ---
            audioPlayer?.volume = volume
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
