////
////  ImagePicker.swift
////  Upload-Image-SwiftUI
////
////  Created by Rexford Machu on 8/14/21.
////
//
//import SwiftUI
//struct ImagePicker: UIViewControllerRepresentable {
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var image: UIImage?
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
//
//    }
//    
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.image = uiImage
//                print("Image: \(uiImage.description)")
//            }
//            else if let uiImage = info[.originalImage] as? UIImage {
//                parent.image = uiImage
//                print("Image: \(uiImage.description)")
//            }
//            else{
//                print("ImagePicker")
//            }
//
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//}
