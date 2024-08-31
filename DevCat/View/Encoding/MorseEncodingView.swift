//
//  MorseEncodingView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import Sisyphus
import SwiftUI

struct MorseEncodingView: View {
    @State private var dit = "." // .
    @State private var dah = "-" // -
    @State private var inputText = ""
    @State private var outputText = ""

    private var morse = MorseCode()

    var body: some View {
        VStack {
            TitleText("Morse Encoding")
            HStack {
                Text(".")
                TextField("Enter text", text: $dit)
                Text("-")
                TextField("Enter text", text: $dah)
            }
            Spacer()
            HStack {
                Button(action: {
                    var text = morse.encode(inputText)
                    if dit != "." || dah != "-" {
                        text = text.replacingOccurrences(of: ".", with: dit)
                        text = text.replacingOccurrences(of: "-", with: dah)
                    }
                    outputText = text
                }, label: { Label("Encode", systemImage: "doc.on.doc") })

                Button(action: {
                    var text = inputText.uppercased()
                    if dit != "." || dah != "-" {
                        text = text.replacingOccurrences(of: dit.uppercased(), with: ".")
                        text = text.replacingOccurrences(of: dah.uppercased(), with: "-")
                    }
                    let ans = morse.decode(text)
                    outputText = ans
                    outputText += "\n\n"
                    outputText += ans.reversed()
                }, label: { Label("Decode", systemImage: "doc.on.doc") })
            }
            Spacer()
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
            VStack {
                HStack {
                    Text("Output")
                    Spacer()
                    CopyButton(text: outputText)
                    TrashButton(text: $outputText)
                }
                MonoTextEditor(text: $outputText)
            }
        }.padding()
    }
}

#Preview {
    MorseEncodingView()
}
