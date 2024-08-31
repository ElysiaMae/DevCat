//
//  UserAgentView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import Sisyphus
import SwiftUI

struct UserAgentView: View {
    @State private var outputArray: [String] = []
    @State private var count: Int = 5
    @State private var outputText = ""

    var body: some View {
        VStack {
            TitleText("Generated User-Agent")
            HStack {
                Stepper(value: $count, in: 1 ... 20) {
                    Text("Number of User-Agent: \(count)")
                }
                Button("Generate \(count) UA") {
                    outputArray = generateRandomUserAgents(count)
                    outputText = outputArray.joined(separator: "\n\n")
                }
                .padding()
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
        }
        .padding()
    }
}

#Preview {
    UserAgentView()
}
