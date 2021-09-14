//
//  CreateQRView.swift
//  QRcodeReader
//
//  Created by Nikudanngo on 2021/09/13.
//

import SwiftUI

class ImageSaver: NSObject {
    @Binding var showAlert: Bool
    
    init(_ showAlert: Binding<Bool>) {
        _showAlert = showAlert
    }
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(didFinishSavingImage), nil)
    }

    @objc func didFinishSavingImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if error != nil {
            print("保存に失敗しました。")
        } else {
            showAlert = true
        }
    }
}


struct CreateQRView: View {
    @State var string:String = ""
        @State var correctionLevel = 0
        @State var qrImage:UIImage?
        private var _QRCodeMaker = QRCodeMaker()
        @State var showAlert = false
        @State private var showActivityView: Bool = false
    @State private var rect: CGRect = .zero
    @State private var uiImage: UIImage? = nil
    @State private var showShareSheet = false

    var body: some View {
        VStack{
            Spacer()
            if qrImage != nil {
                Image(uiImage: qrImage!)
            }
            HStack {
                TextField("URL/Text", text: $string)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: {
                                self.qrImage = self._QRCodeMaker.make(message: self.string, level: self.correctionLevel)
                            }) {
                                Text("作成")
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color(red: 44/225, green: 61/225 , blue: 10/225))
                                    .clipShape(Capsule())
                     }
                .padding()
            }
            HStack {
                Spacer()
                Button(action: {
                        self.showActivityView = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                    }
                    .sheet(isPresented: self.$showActivityView) {
                        ActivityView(
                            activityItems: [qrImage!],
                            applicationActivities: nil
                        )
                    }
                Button(action: {
                    ImageSaver($showAlert).writeToPhotoAlbum(image: qrImage!)
                          }){
                              Image(systemName: "square.and.arrow.down")
                                .font(.title)
                                .padding()
                                .foregroundColor(.white)
                          }.alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("画像を保存しました。"),
                                message: Text(""),
                                dismissButton: .default(Text("OK"), action: {
                                    showAlert = false
                                }))
                          }
            }
            Spacer()
        }
    }
}
// キーボードをしまう関数
// ContentView.swiftで使う
extension UIApplication {
    func closeKeyboad() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct CreateQRView_Previews: PreviewProvider {
    static var previews: some View {
        CreateQRView()
    }
}
