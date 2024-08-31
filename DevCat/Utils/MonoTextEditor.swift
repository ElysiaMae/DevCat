//
//  MonoTextEditor.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/8/30.
//

import SwiftUI

struct MonoTextEditor: View {
    // 绑定的文本输入
    @Binding var text: String

    // 接受自定义字体名称和大小的参数
    @AppStorage(AppSettingsKeys.monoFontName) var monoFontName = "JetBrains Mono"
    @AppStorage(AppSettingsKeys.monoPointSize) var monoPointSize = CGFloat(14)

    // 设置最小高度和圆角半径
    var minHeight: CGFloat = 20
    var cornerRadius: CGFloat = 10

    var body: some View {
        TextEditor(text: $text)
            .frame(minHeight: minHeight) // 设置最小高度
            .cornerRadius(cornerRadius) // 设置圆角
            .font(.custom(monoFontName, size: monoPointSize)) // 设置字体和大小
    }
}

#Preview {
    MonoTextEditor(text: .constant("Sample text"))
}
