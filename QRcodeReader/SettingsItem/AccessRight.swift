//
//  AccessRight.swift
//  QRcodeReader
//
//  Created by Nikudanngo on 2021/09/12.
//

import SwiftUI
import SPPermissions
import SPPermissionsPhotoLibrary
import SPPermissionsCamera

struct AccessRightView: View {
    // 日本語にしたいけどやり方がわからん
    @State private var showingPermisionsController = false
    var body: some View {
        Button("開く") {
            self.showingPermisionsController = true
        }
        .frame(width: 40, height: 5, alignment: .trailing)
        .padding()
        .sheet(isPresented: $showingPermisionsController) {
            SPPermissionsList(permissions: [.camera,.photoLibrary])
        }
    }
    
}
struct AccessRightView_Previews: PreviewProvider {
    static var previews: some View {
        AccessRightView()
    }
}
