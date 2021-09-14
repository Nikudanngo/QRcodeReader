//
//  QRmaker.swift
//  QRcodeReader
//
//  Created by Nikudanngo on 2021/09/13.
//

import SwiftUI

class QRCodeMaker: NSObject {
    private let correctionTexts = ["L"]
    private let context = CIContext()

    func make(message:String , level:Int) -> UIImage? {
        guard let data = message.data(using: .utf8) else { return nil }

        guard let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": getCorrectionText(index: level)]) else { return nil }
        
        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        
        guard let ciImage = qr.outputImage?.transformed(by: sizeTransform) else { return nil }
        
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        
        let image = UIImage(cgImage: cgImage)
        
        return image
    }
    
    func getCorrectionText(index:Int) -> String {
        return correctionTexts[index]
    }

    func getCorrectionCount() -> Int {
        return correctionTexts.count
    }
    
}
// 共有するためのクラス
struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<ActivityView>
    ) -> UIActivityViewController {
        return UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
    }

    func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: UIViewControllerRepresentableContext<ActivityView>
    ) {
        // Nothing to do
    }
}
