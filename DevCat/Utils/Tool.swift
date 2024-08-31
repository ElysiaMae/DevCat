//
//  Tool.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/8/30.
//

import Foundation

import AppKit
import Foundation

// MARK: SwiftUI 剪切板

public func setClipboard(_ text: String) {
    #if os(macOS)
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
    #elseif os(iOS)
//        let clipboard = UIPasteboard.general.setValue(textToCopy, forPasteboardType: /*<#String#>*/)
    #endif
    // 在iOS上，使用.general即可，macOS上可以创建自定义Pasteboard并分配
}

public func getClipboard() -> String {
    #if os(macOS)
        if let clipboardString = NSPasteboard.general.string(forType: .string) {
            return clipboardString
        }
        return ""
    #elseif os(iOS)
        if let clipboardString = UIPasteboard.general.string {
            return clipboardString
        }
        return ""
    #endif
}
