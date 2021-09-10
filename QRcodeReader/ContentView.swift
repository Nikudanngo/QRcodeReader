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
//      Settingページ
struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 80/255, green: 100/255, blue: 255/255)
            }
            .navigationTitle("Setting")
        }
    }
}
// TabBarの処理
//     アイコンを押すとそれぞれのページに変遷
struct ContentView: View {
    var body: some View {
        TabView {
            ScanView()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                }
            CreateView()
                .tabItem {
                    Image(systemName: "qrcode")
                    Text("Create")
                }
            HistorysView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("History")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Setting")
                }
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
