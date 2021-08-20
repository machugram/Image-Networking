//
//  VideoPlayer.swift
//  Upload-Image-SwiftUI
//
//  Created by Rexford Machu on 8/17/21.
//

import SwiftUI
import AVKit

struct VideoCard: View {
    var url : URL
    let delayTime = DispatchTime.now() + 20.0
   @State var image : UIImage? = nil

    var body: some View {
        let player =  AVPlayer(url: url)
        VStack{
//            VideoPlayer(player: player ) {
//            }    .frame(height: 200)
//            .disabled(true)
//            Image(uiImage: AVPlayerControllerRepresented(player: player).createThumbnailOfVideoFromRemoteUrl(url: url)!)
            AVPlayerControllerRepresented(player: player)
                .frame(height: 200)
                .onAppear(){
                    player.play()
                   } //DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
//             //          hello()
//                     player.pause()
//                    })
                    //AVPla
//                    player.play()
//                    player.
                }      //.edgesIgnoringSafeArea(.all)
            
       // }
        
        }
    
    
//    func functionOne() {
//       let delayTime = DispatchTime.now() + 3.0
//       //print("one")
//       DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
////          hello()
//        player.
//       })
//    }
//
}
//@State private var selectedVideo: Video?


struct VideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        VideoCard(url: URL(string: "")!)
    }
}

struct AVPlayerControllerRepresented : UIViewControllerRepresentable {
    var player : AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
    
    func createThumbnailOfVideoFromRemoteUrl(url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
          print(error.localizedDescription)
          return nil
        }
    }
}


func functionOne() {
   let delayTime = DispatchTime.now() + 3.0
   print("one")
   DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
      hello()
   })
}
func hello() {
   print("text")
}
