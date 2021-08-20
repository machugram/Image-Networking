//
//  GIFVideoView.swift
//  Upload-Image-SwiftUI
//
//  Created by Rexford Machu on 8/18/21.
//

import SwiftUI
import UIKit

struct GIFVideoView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
//    
//    func createThumbnailOfVideoFromRemoteUrl(url: URL) -> UIImage? {
//        let asset = AVAsset(url: url)
//        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
//        assetImgGenerate.appliesPreferredTrackTransform = true
//        //Can set this to improve performance if target size is known before hand
//        //assetImgGenerate.maximumSize = CGSize(width,height)
//        let time = CMTimeMakeWithSeconds(1.0, 600)
//        do {
//            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
//            let thumbnail = UIImage(cgImage: img)
//            return thumbnail
//        } catch {
//          print(error.localizedDescription)
//          return nil
//        }
//    }
}

struct GIFVideoView_Previews: PreviewProvider {
    static var previews: some View {
        GIFVideoView()
    }
}


