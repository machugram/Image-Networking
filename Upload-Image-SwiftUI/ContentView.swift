//
//  ContentView.swift
//  Upload-Image-SwiftUI
//
//  Created by Rexford Machu on 8/14/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var image : Image? = nil

    //private let onImagePicked: (UIImage) -> Void

    var body: some View {
        
        VStack{
            Spacer()
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
                uploadImageToTask()
            }, label: {
                Text("Upload Image")
            })
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                                self.image = Image(uiImage: image)
                            }
            
        }
    }
    
    func loadImage() {
        print("Hi")
        self.image = Image(systemName: "star.fill")
        guard let inputImage = inputImage else { return }
        self.image = Image(uiImage: inputImage)
        print(image.debugDescription)
        print(image.debugDescription)

    }
    
    
    func uploadImageToTask(){
        guard let image = image else { return  }
        
        
        let filename = "avatar.png"
        let boundary = UUID().uuidString
        let fieldName = "reqtype"
        let fieldValue = "fileupload"
        
//        let fieldName2 = "other field name"
//        let fieldValue2 = "other field value"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: URL(string: "https://catbox.moe/user/api.php")!)
        urlRequest.httpMethod = "POST"
        
        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data in a web browser
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        // Add the field name and field value to the raw http request data
        // put two dashes ("-") in front of boundary string to separate different field/values
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(fieldName)\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(fieldValue)".data(using: .utf8)!)
        
        // If you want to add another field, uncomment this
        // Copy and paste the following block if you want to add another field
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"\(fieldName2)\"\r\n\r\n".data(using: .utf8)!)
//        data.append("\(fieldValue2)".data(using: .utf8)!)
        
        // Add the image to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"fileToUpload\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.asUIImage().resizedTo1MB()!.pngData()!)

        // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
        // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
//        uploadActivityIndicator.isHidden = false
//        uploadActivityIndicator.startAnimating()
//        uploadImageButton.isEnabled = false
        print("Running: \(data)")
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            
            // session upload task will use a background thread to run the data upload task, so that the main UI operation wont get frozen
            // we will need to use back the main thread to change the UI
            DispatchQueue.main.async {
                print("Done Running")
//                self.uploadActivityIndicator.stopAnimating()
//                self.uploadActivityIndicator.isHidden = true
//                self.uploadImageButton.isEnabled = true
            }
            
            if(error != nil){
                print("\(error!.localizedDescription)")
            }
            
            guard let responseData = responseData else {
                print("no response data")
                return
            }
            
            if let responseString = String(data: responseData, encoding: .utf8) {
                print("uploaded to: \(responseString)")
            }
        }).resume()
    }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    private var presentationMode

    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void

    final class Coordinator: NSObject,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {

        @Binding
        private var presentationMode: PresentationMode
        private let sourceType: UIImagePickerController.SourceType
        private let onImagePicked: (UIImage) -> Void

        init(presentationMode: Binding<PresentationMode>,
             sourceType: UIImagePickerController.SourceType,
             onImagePicked: @escaping (UIImage) -> Void) {
            _presentationMode = presentationMode
            self.sourceType = sourceType
            self.onImagePicked = onImagePicked
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            onImagePicked(uiImage)
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode,
                           sourceType: sourceType,
                           onImagePicked: onImagePicked)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}
