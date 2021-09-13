//
//  CreateQRView.swift
//  QRcodeReader
//
//  Created by 遠藤さとる on 2021/09/13.
//

import SwiftUI


struct CreateQRView: View {
    @State var string:String = ""
        @State var correctionLevel = 0
        @State var qrImage:UIImage?
        private var _QRCodeMaker = QRCodeMaker()
    
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
//            .frame(alignment: .leading)
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
