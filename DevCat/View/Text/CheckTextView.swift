//
//  CheckTextView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/9/2.
//

import Combine
import Sisyphus
import SwiftUI

struct CheckTextView: View {
    @State private var inputText = ""
    @State private var outputText = ""

    var body: some View {
        VStack {
            TitleText("Check Text")
            Spacer()

            VStack(alignment: .leading) {
                HStack {
                    Text("Input")
                    Spacer()
                    PasteButton(text: $inputText)
                    TrashIconButton(text: $inputText)
                }
                MonoTextEditor(text: $inputText)
            }
            Spacer()

            VStack(alignment: .leading) {
                HStack {
                    Text("Output")
                    Spacer()
                    CopyButton(text: outputText)
                    TrashIconButton(text: $outputText)
                }
                MonoTextEditor(text: $outputText)
            }
        }
        .onReceive(Just(inputText)) { newText in
            outputText = newText.showAllUnicodeCharacters()
        }
        .padding()
    }
}

#Preview {
    CheckTextView()
}
