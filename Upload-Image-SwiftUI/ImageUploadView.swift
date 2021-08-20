//
//  ImageUploadView.swift
//  Upload-Image-SwiftUI
//
//  Created by Rexford Machu on 8/16/21.
//

import SwiftUI

struct ImageUploadView: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var image : Image? = nil
    @State var isLoading: Bool = false
    var body: some View {
        VStack{
            
            Spacer()
            if (isLoading){
                ZStack{
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
            }
            Button(action: {
                self.showingImagePicker.toggle()

            }, label: {
                Text("Select Image")
            })
            Spacer()
            image?
                .resizable()
                .frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Spacer()

            Button(action: {
                isLoading = true
//                if (isLoading){
//                    overlay(
//                        ProgressView().progressViewStyle(CircularProgressViewStyle())
//                    )
//                }
                    
                let ImageNetwork =  ImageNetworking(image: image, filename: "profile.png", resource: "https://catbox.moe/user/api.php", shouldImageLess1MB: true)
                ImageNetwork.uploadImageToTask(image: image, filename: "profile.png", resource: "https://catbox.moe/user/api.php"){
                    result in
                    switch(result){
                    case .success(let response):
                        print(response)
                        print(String(data: response, encoding: .utf8))
                        self.isLoading = false
                    case .failure(let error):
                        self.isLoading = false
                        print(error.localizedDescription)
                    }
                }
                
            }, label: {
                Text("Upload Image")
            })
            
            Button(action: {
                isLoading = false

            }, label: {
                Text("False")
            })
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                                self.image = Image(uiImage: image)
                            }
            
        }
    }
}

struct ImageUploadView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploadView()
    }
}
