//
//  SettingsView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/8/11.
//

import SwiftUI

struct SettingsView: View {
    @State private var font: NSFont = .systemFont(ofSize: 24)

    var body: some View {
        VStack {
            Spacer()
            FontPicker("Font", selection: $font)
                .padding()
            Spacer()
//            NavigationSplitView {
//                SideBarView()
//            } detail: {
//                DetailView()
//            }
        }
        .scenePadding()
//        .frame(maxWidth: 350, minHeight: 100)
    }
}

struct GeneralSettingsView: View {
    @AppStorage("showPreview") private var showPreview = true
    @AppStorage("fontSize") private var fontSize = 12.0

    var body: some View {
        Form {
            Toggle("Show Previews", isOn: $showPreview)
            Slider(value: $fontSize, in: 9 ... 96) {
                Text("Font Size (\(fontSize, specifier: "%.0f") pts)")
            }
        }
    }
}

#Preview {
    SettingsView()
}
