//
//  HashView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import Combine
import Sisyphus
import SwiftUI

struct HashView: View {
    @State private var inputText = ""
    @State private var md5Text = ""
    @State private var sha1Text = ""
    @State private var sha256Text = ""
    @State private var sha384Text = ""
    @State private var sha512Text = ""

    var body: some View {
        VStack {
            TitleText("Hash View")
            HStack {
                TextField("inputText", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    inputText = getClipboard()
                }, label: { Label("Paste", systemImage: "doc.on.clipboard") })
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("MD5")
                HStack {
                    MonoTextField(text: $md5Text)
                    Spacer()
                    CopyButton(text: md5Text)
                }
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Sha1")
                HStack {
                    MonoTextField(text: $sha1Text)
                    Spacer()
                    CopyButton(text: sha1Text)
                }
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Sha256")
                HStack {
                    MonoTextField(text: $sha256Text)
                    Spacer()
                    CopyButton(text: sha256Text)
                }
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Sha384")
                HStack {
                    MonoTextField(text: $sha384Text)
                    Spacer()
                    CopyButton(text: sha384Text)
                }
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Sha512")
                HStack {
                    MonoTextField(text: $sha512Text)
                    Spacer()
                    CopyButton(text: sha512Text)
                }
            }
            Spacer()
        }
        .padding()
        .onReceive(Just(inputText)) { newText in
            md5Text = md5Hash(newText)
            sha1Text = shaHash(newText, algorithm: ShaHashAlgorithm.sha1)
            sha256Text = shaHash(newText, algorithm: ShaHashAlgorithm.sha256)
            sha384Text = shaHash(newText, algorithm: ShaHashAlgorithm.sha384)
            sha512Text = shaHash(newText, algorithm: ShaHashAlgorithm.sha512)
        }
    }
}

#Preview {
    HashView()
        .environment(\.locale, .init(identifier: "zh-Hant"))
}
