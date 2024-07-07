//
//  CategoryType.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import Foundation
import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let detailView: AnyView
}

enum CategoryType: String, CaseIterable, Identifiable {
    case encoding
    case generate
    case math
    case crypto
    case classicalCipher
    case text
    case image
    case other

    var id: String { rawValue }

    var localizedName: LocalizedStringKey {
        switch self {
        case .encoding: return "Encoding"
        case .generate: return "Generate"
        case .math: return "Math"
        case .crypto: return "Crypto"
        case .classicalCipher: return "ClassicalCipher"
        case .text: return "Text"
        case .image: return "Image"
        case .other: return "Other"
        }
    }

    var icon: String {
        switch self {
        case .encoding: return "function"
        case .generate: return "wand.and.stars"
        case .math: return "x.squareroot"
        case .crypto: return "key"
        case .classicalCipher: return "key.fill"
        case .text: return "textformat"
        case .image: return "photo"
        case .other: return "ellipsis"
        }
    }

    var products: [Product] {
        switch self {
        case .encoding:
            [
                Product(name: "Base", detailView: AnyView(BaseEncodingView())),
                Product(name: "FileHash", detailView: AnyView(FileHashView())),
                Product(name: "Hash", detailView: AnyView(HashView())),
                Product(name: "HTML", detailView: AnyView(HTMLEncodingView())),
                Product(name: "Morse", detailView: AnyView(MorseView())),
                Product(name: "String", detailView: AnyView(StringEncodingView())),
                Product(name: "URL", detailView: AnyView(URLEncodingView()))
            ]
        case .generate:
            [
                Product(name: "UserAgent", detailView: AnyView(UserAgentView())),
                Product(name: "UUID", detailView: AnyView(UUIDView()))
            ]
        case .math:
            [
                Product(name: "PrimeNumber", detailView: AnyView(PrimeNumberView()))
            ]
        case .crypto:
            [
                Product(name: "AES", detailView: AnyView(AESView())),
                Product(name: "DES", detailView: AnyView(DESView()))
            ]
        case .classicalCipher:
            [
                Product(name: "CaesarCipher", detailView: AnyView(CaesarCipherView())),
                Product(name: "ChinaCore", detailView: AnyView(ChinaCoreView()))
            ]
        case .text:
            [
                Product(name: "RegexTester", detailView: AnyView(RegexTesterView()))
            ]
        case .image:
            [
                Product(name: "DropImage", detailView: AnyView(DropImageView()))
            ]
        case .other:
            [
                Product(name: "Scan", detailView: AnyView(ScanView()))
            ]
        }
    }
}
