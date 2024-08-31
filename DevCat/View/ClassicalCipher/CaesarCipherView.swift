//
//  CaesarCipherView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import Sisyphus
import SwiftUI

struct CaesarCipherView: View {
    @State private var inputText = ""
    @State private var outputArray: [String] = []
    @State private var outputText = ""

    var body: some View {
        VStack {
            TitleText("Caesar Cipher")
            Spacer()
            MonoTextField(text: $inputText)
            Spacer()
            Button(action: {
                outputArray = caesarCipherDecrypt(inputText)
                outputText = outputArray.joined(separator: "\n")
            }, label: {
                Text("Decryption")
            })
            Spacer()
            VStack {
                HStack {
                    Text("Output")
                    Spacer()
                    CopyButton(text: outputText)
                    TrashButton(text: $outputText)
                }
                MonoTextEditor(text: $outputText)
            }
        }
        .padding()
    }
}

#Preview {
    CaesarCipherView()
}
