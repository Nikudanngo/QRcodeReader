//
//  ContentView.swift
//  QRcodeReader
//
//  Created by Nikudanngo on 2021/09/08.
//

import SwiftUI
// tabBarの各種ページ
//      Scanページ
struct ScanView: View {
    var body: some View {
        ZStack {
            Image("bg1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.top)
            VStack {
                Text("Scan")
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
}
//      Createページ
struct CreateView: View {
    var body: some View {
        ZStack {
            Image("bg2")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.top)
            VStack {
                Text("Create")
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
}
//      Historyページ
struct HistorysView: View {
    var body: some View {
        ZStack {
            Image("bg3")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.top)
            VStack {
                Text("History")
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
}
//　    　SettingページはSettingView.swiftに移動したよ
//struct SettingsView: View {
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Color("label")
//            }
//            .navigationTitle("Setting")
//        }
//    }
//}
// TabBarの処理
//     アイコンを押すとそれぞれのページに変遷
struct ContentView: View {
    // ついでにスワイプに対応してタブを切り替えられるようにする
    @State private var selectedTab = 0
    // tabView(引数){}で引数に用意したtagに飛ぶことができるのでこれを利用する
    
// これでスワイプの感度を確かめる
//    private func handleSwipe(translation: CGFloat) {
//        print("handling swipe! horizontal translation was \(translation)")
//    }
    let minDragTranslationForSwipe: CGFloat = 100 // スワイプの感度を設定
    let numTabs = 4     //タブの上限を設定
    // スワイプを検知するとタブを表示する引数を上下させる
    private func handleSwipe(translation: CGFloat) {
        if translation > minDragTranslationForSwipe && selectedTab > 0 {
            selectedTab -= 1
        } else  if translation < -minDragTranslationForSwipe && selectedTab < numTabs-1 {
            selectedTab += 1
        }
    }
    var body: some View {
        TabView(selection: $selectedTab) {
            ScanView()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                }.tag(0)
                .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
            CreateView()
                .tabItem {
                    Image(systemName: "qrcode")
                    Text("Create")
                }.tag(1)
                .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
            HistorysView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("History")
                }.tag(2)
                .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Setting")
                }.tag(3)
                .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 12 Pro Max")
            ContentView()
                .previewDevice("iPhone 8")
           
        }
    }
}
