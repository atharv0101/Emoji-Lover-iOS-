import AVFoundation
import SwiftUI

class BackgroundMusicPlayer {
    static let instance = BackgroundMusicPlayer()
    var audioPlayer: AVAudioPlayer?
    
    // We use @AppStorage to automatically check the user's setting
    @AppStorage("isMusicEnabled") private var isMusicEnabled: Bool = true

    func start() {
        // Only start playing if the music setting is enabled and it's not already playing
        guard isMusicEnabled, audioPlayer?.isPlaying == false else { return }
        
        guard let url = Bundle.main.url(forResource: "backgroundmusic", withExtension: "aif") else {
            print("Error: Could not find backgroundmusic.aif")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // -1 means loop forever
            audioPlayer?.volume = 1 // Start with a low volume
            audioPlayer?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }

    func stop() {
        audioPlayer?.stop()
    }
    
    // This function will be called by our settings toggle
    func toggle() {
        if isMusicEnabled {
            start()
        } else {
            stop()
        }
    }
}
