//
//  SettingView.swift
//  QRcodeReader
//
//  Created by Nikudanngo on 2021/09/11.
//

import SwiftUI
//import SPPermissions
//import SPPermissionsCamera
//import SPPermissionsPhotoLibrary

struct SettingsView: View {
    
    @State private var protectHistory = false
    @State private var reduceAds = false
    @State private var pickerSelection = 0
    @State var showModal = false
    @State private var showingPermisionsController = false
    let languages: [String] = [
        "日本語"
//      "English",みたいにすると選択肢増やせる
    ]
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("アップグレードする")) {
                    HStack {
                        Picker(selection: $pickerSelection, label: Text("プレミアムへ")) {
                            
                        }
                    }
                    HStack {
                        Picker(selection: $pickerSelection, label: Text("言語")) {
                            ForEach(0..<self.languages.count) { index in
                                Text(self.languages[index])
                            }
                        }
                    }
                    HStack {
                        Picker(selection: $pickerSelection, label: Text("広告を見て全ての機能を有効にする")) {
                            
                        }
                    }
                }
                Section(header: Text("カスタム設定")) {
                    HStack {
                        Text("広告を減らす")
                        Spacer()
                        // あとでここにif書いてプレミアムがonになっていれば全てtrueにする
                        Toggle(isOn: $reduceAds) {
                            Image(systemName: "lock")
                            //Image(systemName: "lock.open")
                        }
                    }
                    HStack {
                        Text("履歴を保護する")
                        Spacer()
                        // あとでここにif書いてプレミアムがonになっていれば全てtrueにする
                        Toggle(isOn: $protectHistory) {
                            Image(systemName: "lock")
                            // Image(systemName: "lock")
                        }
                    }
                }
                Section(header: Text("その他")) {
                    HStack {
                        Text("アクセス権利を確認する")
                        Spacer()
                        AccessRightView() // 権限をアラートする,英語UIの方を使用
                    }
                    HStack {
                        Picker(selection: $pickerSelection, label: Text("利用規約を確認する")) {
                        }
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .previewDevice("iPhone 12 Pro Max")
    }
}
