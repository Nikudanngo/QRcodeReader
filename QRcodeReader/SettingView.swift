//
//  SettingView.swift
//  QRcodeReader
//
//  Created by Nikudanngo on 2021/09/11.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isOn = false
    @State private var pickerSelection = 0
    
    let languages: [String] = [
        "日本語"
//      "English",みたいにすると選択肢増やせる
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("アップグレードする")) {
                    HStack {
                        Text("プレミアムへ")
                        Spacer()
                        Toggle(isOn: $isOn) {
                            EmptyView()
                        }
                    }
                    HStack {
                        Picker(selection: $pickerSelection, label: Text("Language")) {
                            ForEach(0..<self.languages.count) { index in
                                Text(self.languages[index])
                            }
                        }
                    }
                    HStack {
                        Picker(selection: $pickerSelection, label: Text("広告を見て全ての機能を有効にする")) {
                            ForEach(0..<self.languages.count) { index in
//                                Text(self.languages[index])
                            }
                        }
                    }
                }
                Section(header: Text("カスタム設定")) {
                    HStack {
                        Text("広告を減らす")
                        Spacer()
                        Toggle(isOn: $isOn) {
                            EmptyView()
                        }
                    }
                    HStack {
                        Text("履歴を保護する")
                        Spacer()
                        Toggle(isOn: $isOn) {
                            EmptyView()
                        }
                    }
                }
                Section(header: Text("その他")) {
                    HStack {
                        Picker(selection: $pickerSelection, label: Text("権利を確認する")) {
                            ForEach(0..<self.languages.count) { index in
//                                Text(self.languages[index])
                            }
                        }
                        
                    }
                    HStack {
                        Picker(selection: $pickerSelection, label: Text("利用規約を確認する")) {
                            ForEach(0..<self.languages.count) { index in
//                                Text(self.languages[index])
                            }
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
