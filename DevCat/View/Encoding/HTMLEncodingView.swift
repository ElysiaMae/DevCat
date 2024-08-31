//
//  HTMLEncodingView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import Sisyphus
import SwiftUI

struct HTMLEncodingView: View {
    @State private var inputText = ""
    @State private var outputText = ""

    var body: some View {
        VStack {
            TitleText("HTML Encoding")
            HStack {
                Button(action: {
                    outputText = htmlEncode(inputText) ?? "nil"
                }, label: { Label("Encode", systemImage: "doc.on.doc") })

                Button(action: {
                    outputText = htmlEncode(inputText) ?? "nil"
                }, label: { Label("Decode", systemImage: "doc.on.doc") })
            }
            Spacer()

            // MARK: Input

            VStack {
                HStack {
                    Text("Input")
                    Spacer()
                    PasteButton(text: $inputText)
                    TrashButton(text: $inputText)
                }
                MonoTextEditor(text: $inputText)
            }
            Spacer()

            // MARK: Output

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
    HTMLEncodingView()
}
