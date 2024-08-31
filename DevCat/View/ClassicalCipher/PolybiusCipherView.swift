//
//  PolybiusCipherView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/8/26.
//

import Sisyphus
import SwiftUI

struct PolybiusCipherView: View {
    @State private var inputText = ""
    @State private var outputText = ""

    var body: some View {
        VStack {
            TitleText("Polybius Cipher")
            HStack {
                Button("Encode") {
                    let cipher = PolybiusCipher()
                    outputText = cipher.encrypt(inputText)
                }
                Button("Decode") {
                    let cipher = PolybiusCipher()
                    outputText = cipher.decrypt(inputText) ?? ""
                }
            }
            Spacer()

            VStack(alignment: .leading) {
                HStack {
                    Text("Input")
                    Spacer()
                    PasteButton(text: $inputText)
                    TrashButton(text: $inputText)
                }
                MonoTextEditor(text: $inputText)
            }
            Spacer()

            VStack(alignment: .leading) {
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
    PolybiusCipherView()
}
