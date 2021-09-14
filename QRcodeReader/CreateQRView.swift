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
                    .resizable()
                    .frame(width: 300, height: 300)
            }
            HStack(alignment: .top){
//                TextField("URL/Text", text: $string)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
                // 複数行入力
                Spacer()
                            MultilineTextField(text: $string)
                                .frame(width: UIScreen.main.bounds.width * 0.7, height: 140)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 3)
                                )
                                .opacity(0.4)
                Button(action: {
                                self.qrImage = self._QRCodeMaker.make(message: self.string, level: self.correctionLevel)
                                UIApplication.shared.closeKeyboad() //作成ボタン押すとキーボードをしまう
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
                //　左寄寄せするならこれ↓
//                Spacer()
                // 画像がないのに共有するとerror出るからqr生成前には隠しておく
                if qrImage != nil {
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
                }
                // 画像がないのに保存するとerror出るからqr生成前には隠しておく
                if qrImage != nil {
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
// 複数行入力するためのTextField
struct MultilineTextField: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.font = UIFont.systemFont(ofSize: 18)
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator : NSObject, UITextViewDelegate {

        var parent: MultilineTextField

        init(_ textView: MultilineTextField) {
            self.parent = textView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
}

struct CreateQRView_Previews: PreviewProvider {
    static var previews: some View {
        CreateQRView()
    }
}
