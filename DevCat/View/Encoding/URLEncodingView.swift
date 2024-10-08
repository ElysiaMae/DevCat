//
//  URLEncodingView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import Sisyphus
import SwiftUI

struct URLEncodingView: View {
    @State private var inputText = ""
    @State private var outputText = ""

    var body: some View {
        VStack {
            TitleText("URL Encoding")
            HStack {
                Button("Encode") {
                    outputText = urlEncode(inputText) ?? "nil"
                }
                Button("Decode") {
                    outputText = urlDecode(inputText) ?? "nil"
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
    URLEncodingView()
}
