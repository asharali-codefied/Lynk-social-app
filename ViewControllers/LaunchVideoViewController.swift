import UIKit
import AVFoundation

class LaunchVideoViewController: UIViewController{
    private var player :AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .black
        playLaunchVideo()
    }
    
    private func playLaunchVideo(){
        guard let path = Bundle.main.path(forResource: "launch-video", ofType: "mp4") else{
            print("🚨 launch_intro.mp4 not found")
            transitionToMainApp()
            return;
        }
        
        let playerItem = AVPlayerItem(url: URL(filePath: path))
        player = AVPlayer(playerItem: playerItem);
        playerLayer = AVPlayerLayer(player: player);
        
        guard let playerLayer = playerLayer else { return }
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidFinish), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
       player?.play()
        
        // Add a tap gesture recognizer to skip the video
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(videoDidFinish))
        view.addGestureRecognizer(tapGesture)
    
    }
    
    @objc private func videoDidFinish(){
        transitionToMainApp()
    }
    
    private func transitionToMainApp(){
        let getStartedVC = GetStartedViewController()
        let navController = UINavigationController(rootViewController: getStartedVC);
        guard let window = UIApplication.shared.connectedScenes.compactMap({($0 as? UIWindowScene)?.keyWindow}).first else{ return};
        
        window.rootViewController = navController
               window.makeKeyAndVisible()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
