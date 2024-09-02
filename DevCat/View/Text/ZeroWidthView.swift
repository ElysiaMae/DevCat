//
//  ZeroWidthView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/9/1.
//

import Sisyphus
import SwiftUI

struct ZeroWidthView: View {
    @State private var visibleText = "" // 可见文本
    @State private var hiddenText = "" // 隐藏文本
    @State private var encodedText = "" // 已编码文本
    @State private var splitText = "" // 零宽字符分隔文本

    var body: some View {
        VStack {
            TitleText("Zero Width")
            Spacer()
            HStack {
                VStack {
                    HStack {
                        Text("Visible Text")
                        Spacer()
                        CopyIconButton(text: visibleText)
                        PasteIconButton(text: $visibleText)
                        TrashIconButton(text: $visibleText)
                    }
                    MonoTextEditor(text: $visibleText)
                }
                Spacer()

                VStack {
                    HStack {
                        Text("Invisible Text")
                        Spacer()
                        CopyIconButton(text: hiddenText)
                        PasteIconButton(text: $hiddenText)
                        TrashIconButton(text: $hiddenText)
                    }
                    MonoTextEditor(text: $hiddenText)
                }
            }
            Spacer()

            HStack {
                Button("Encode") {
                    encodedText = ZeroWidth.encode(visibleText: visibleText, hiddenText: hiddenText)
                    splitText = ZeroWidth.split(visibleText)
                }
                Button("Decode") {
                    // TODO: 解码有问题
                    let extracted = ZeroWidth.decode(encodedText)
                    visibleText = extracted.visible
                    hiddenText = extracted.hidden
                }
            }
            Spacer()

            VStack {
                HStack {
                    Text("Encoded Text")
                    Spacer()
                    CopyIconButton(text: encodedText)
                    PasteIconButton(text: $encodedText)
                    TrashIconButton(text: $encodedText)
                }
                MonoTextEditor(text: $encodedText)
            }
            Spacer()

            VStack {
                HStack {
                    // TODO: 提示组件
                    Text("Split Text")
                    Spacer()
                    CopyIconButton(text: splitText)
                    PasteIconButton(text: $splitText)
                    TrashIconButton(text: $splitText)
                }
                MonoTextEditor(text: $splitText)
            }
        }
        .padding()
    }
}

#Preview {
    ZeroWidthView()
}
