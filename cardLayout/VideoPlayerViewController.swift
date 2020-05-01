import UIKit
import AVKit

class VideoPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url =  "https://s3.amazonaws.com/video-api-prod/assets/1c73226459a64410a1adc5dbda78b270/BFV15301_FamousSandwichesFrom4Cities_fb1.mp4"
        
        let videoURL = URL(string: url)
        
        let video = AVPlayer(url: videoURL!)
        let videoPlayer = AVPlayerViewController()
        videoPlayer.player = video
        present(videoPlayer, animated: true, completion: {
            video.play()
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
