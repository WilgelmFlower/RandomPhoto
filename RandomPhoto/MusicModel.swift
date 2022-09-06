import AVFoundation

//MARK: - Class MusicPlayer

class MusicPlayer {
    
    static let shared = MusicPlayer()
    var player: AVAudioPlayer?
    
    func startStopMusicPlayer() {
        if let player = player, player.isPlaying {
            player.stop()
        } else {
            let urlString = Bundle.main.path(forResource: "audio", ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default )
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                guard let urlString = urlString else { return }
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString ))
                guard let player = player else { return }
                player.numberOfLoops = -1
                player.play()
            }
            catch {
                print("something went wrong")
            }
        }
    }
}
