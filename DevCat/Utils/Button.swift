//
//  Button.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/8/30.
//

import SwiftUI

// MARK: Copy Button

struct CopyButton: View {
    var text: String
    @State private var isAnimating = 0

//    init(_ text: Binding<String>) {
//        self._text = text
//    }

    var body: some View {
        Button(
            action: {
                isAnimating += 1
                setClipboard(text)
            },
            label: {
                Label("Copy", systemImage: "doc.on.doc")
            }
        )
        .symbolEffect(.bounce.up.byLayer, value: isAnimating)
        .onTapGesture {
            isAnimating += 1
        }
    }
}

// MARK: Paste Button

struct PasteButton: View {
    @Binding var text: String
    @State private var isAnimating = 0

    var body: some View {
        Button(
            action: {
                isAnimating += 1
                text = getClipboard()
            },
            label: {
                Label("Paste", systemImage: "doc.on.clipboard")
            }
        )
        .symbolEffect(.bounce.up.byLayer, value: isAnimating)
        .onTapGesture {
            isAnimating += 1
        }
    }
}

// MARK: Trash Button

struct TrashButton: View {
    @Binding var text: String
    @State private var isAnimating = 0

    var body: some View {
        Button(
            action: {
                isAnimating += 1
                text = ""
            },
            label: {
                Image(systemName: "trash")
            }
        )
        .symbolEffect(.pulse, value: isAnimating)
        .onTapGesture {
            isAnimating += 1
        }
    }
}

#Preview {
    CopyButton(text: "Sample text")
}
