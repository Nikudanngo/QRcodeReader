//
//  SwiftUIView.swift
//  QRcodeReader
//
//  Created by Nikudanngo on 2021/09/12.
//
// こっちは表示後すぐに消えてしまうバグにより使えない（ ;  ; ）
import SwiftUI
import PermissionsSwiftUIPhoto
import PermissionsSwiftUICamera

struct AccessSetting: View {
    @State var showModal = false
    var body: some View {
        Button(action: {
            showModal = true
        }, label: {
            Text("確認")
        })
        
        .JMModal(showModal: $showModal, for: [.photo, .camera])
//        .JMAlert(showModal: $showModal, for: [.photo, .camera])
        .setPermissionComponent(for: .photo,
                                image: AnyView(Image(systemName: "photo")),
                                title: "写真",
                                description: "写真へのアクセスを許可してください")
        .setPermissionComponent(for: .camera,
                                image: AnyView(Image(systemName: "camera.fill")),
                                title: "Camera",
                                description: "カメラへのアクセスを許可してください")
        .changeHeaderTo("アクセス権を設定")
        .changeHeaderDescriptionTo("QRコードを読み込むために使用します。")
        .changeBottomDescriptionTo("QRコードを読み込むために使用します。カメラ及び写真にアクセス権が与えられなかった場合、一部の機能がご利用いただけません。")
        
    }
}

struct AccessSetting_Previews: PreviewProvider {
    static var previews: some View {
        AccessSetting()
    }
}
