//
//  ImageNetworking.swift
//  Upload-Image-SwiftUI
//
//  Created by Rexford Machu on 8/16/21.
//

import SwiftUI

class ImageNetworking {
   var image : Image? ,filename: String, resource: String,shouldImageLess1MB : Bool
    init(image : Image? ,filename: String, resource: String,shouldImageLess1MB : Bool
) {
        self.image = image
        self.filename = filename
        self.resource = resource
        self.shouldImageLess1MB = shouldImageLess1MB

    }
func uploadImageToTask(image : Image? ,filename: String, resource: String ,completion: @escaping (Result<Data,Error>) -> Void){
    guard let image = image else { return  }
    
    
    let filename = filename
    let boundary = UUID().uuidString
    let fieldName = "reqtype"
    let fieldValue = "fileupload"
    
    
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    // Set the URLRequest to POST and to the specified URL
//        var urlRequest = URLRequest(url: URL(string: "https://catbox.moe/user/api.php")!)
    var urlRequest = URLRequest(url: URL(string: resource)!)

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
    if shouldImageLess1MB {
        data.append(image.asUIImage().resizedTo1MB()!.pngData()!)

    }
    else{
        data.append(image.asUIImage().pngData()!)
    }
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
            guard let responseData = responseData else {
                print("no response data")
                return
            }
            
//            if let responseString = String(data: responseData, encoding: .utf8) {
//                print("uploaded to: \(responseString)")
//            }
           
            completion(.success(responseData))
//                self.uploadActivityIndicator.stopAnimating()
//                self.uploadActivityIndicator.isHidden = true
//                self.uploadImageButton.isEnabled = true
        }
        
        if(error != nil){
            //print("\(error!.localizedDescription)")
            completion(.failure(error!))
        }
        
//            guard let responseData = responseData else {
//                print("no response data")
//                return
//            }
//
//            if let responseString = String(data: responseData, encoding: .utf8) {
//                print("uploaded to: \(responseString)")
//            }
    }).resume()
}
}
