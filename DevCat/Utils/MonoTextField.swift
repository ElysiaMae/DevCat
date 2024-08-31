//
//  MonoTextField.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/8/30.
//

import SwiftUI

struct MonoTextField: View {
    @Binding var text: String

    var titleKey: String = "Text"

    // 接受自定义字体名称和大小的参数
    @AppStorage(AppSettingsKeys.monoFontName) var monoFontName = "JetBrains Mono"
    @AppStorage(AppSettingsKeys.monoPointSize) var monoPointSize = CGFloat(14)

    var body: some View {
        TextField("Text", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .font(.custom(monoFontName, size: monoPointSize)) // 设置字体和大小
    }
}

#Preview {
    MonoTextField(text: .constant("Sample text"))
}
