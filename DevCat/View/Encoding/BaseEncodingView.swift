//
//  BaseEncodingView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import Sisyphus
import SwiftUI

enum EncodingType: String, CaseIterable {
    case base16 = "Base16"
    case base32 = "Base32"
    case base64 = "Base64"
    case base85 = "Base85"
}

struct BaseEncodingView: View {
    @State private var selectedEncodingType: EncodingType = .base64
    @State private var encodingTypes: [String] = ["Base16", "Base32", "Base64", "Base85"]

    @State private var inputText = ""
    @State private var outputText = ""

    var body: some View {
        VStack {
            TitleText("Base Encoding")
            HStack {
                Picker("Select Interface:", selection: $selectedEncodingType) {
                    ForEach(EncodingType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                //            .onChange(of: selectedEncodingType) { _, newEncodingType in
                //                if !inputText.isEmpty {
                //                    switch newEncodingType {
                //                        case .Base16:
                //                            outputText = base16Decode(outputText) ?? ""
                //                        default:
                //                            outputText = ""
                //                    }
                //                }
                //            }
            }
            Spacer()
            HStack {
                Button(action: {
                    switch selectedEncodingType {
                        case .base16:
                            outputText = base16Encode(inputText) ?? ""
                        case .base32:
                            outputText = base32Encode(inputText) ?? ""
                        case .base64:
                            outputText = base64EncodeData(inputText + "==") ?? ""
                        case .base85:
                            outputText = base85Encode(inputText) ?? ""
                    }
                }, label: { Label("Encode", systemImage: "doc.on.doc") })

                Button(action: {
                    switch selectedEncodingType {
                        case .base16:
                            outputText = base16Decode(inputText) ?? ""
                        case .base32:
                            outputText = base32Decode(inputText) ?? ""
                        case .base64:
                            outputText = base64DecodeData(inputText) ?? ""
                        case .base85:
                            outputText = base85Decode(inputText) ?? ""
                    }
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
    BaseEncodingView()
}
