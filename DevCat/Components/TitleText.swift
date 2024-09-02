//
//  TitleText.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/8/31.
//

import SwiftUI

struct TitleText: View {
    var text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.title2)
    }
}

#Preview {
    TitleText("Hello")
}
