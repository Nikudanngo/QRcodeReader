//
//  ContentView.swift
//  QRcodeReader
//
//  Created by Nikudanngo on 2021/09/08.
//

import SwiftUI

struct ScanView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 30/255, green: 144/255, blue: 200/255)
            }
            .navigationTitle("Scan")
        }
    }
}

struct CreateView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 30/255, green: 144/255, blue: 100/255)
            }
            .navigationTitle("Create")
        }
    }
}

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
        ContentView()
    }
}
