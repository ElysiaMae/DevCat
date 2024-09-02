//
//  CategoryType.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import Foundation
import SwiftUI

// MARK: - Product

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let detailView: AnyView
}

// MARK: - CategoryType

enum CategoryType: String, CaseIterable, Identifiable {
    case encoding
    case generate
    case math
    case crypto
    case classicalCipher
    case text
    case image
    case finance
    case other

    var id: String { rawValue }

    var localizedName: LocalizedStringKey {
        switch self {
        case .encoding: "Encoding"
        case .generate: "Generate"
        case .math: "Math"
        case .crypto: "Crypto"
        case .classicalCipher: "ClassicalCipher"
        case .text: "Text"
        case .image: "Image"
        case .finance: "Finance"
        case .other: "Other"
        }
    }

    var icon: String {
        switch self {
        case .encoding: "function"
        case .generate: "wand.and.stars"
        case .math: "x.squareroot"
        case .crypto: "key"
        case .classicalCipher: "key.fill"
        case .text: "textformat"
        case .image: "photo"
        case .finance: "dollarsign.circle"
        case .other: "ellipsis"
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
                Product(name: "Morse", detailView: AnyView(MorseEncodingView())),
                Product(name: "String", detailView: AnyView(StringEncodingView())),
                Product(name: "URL", detailView: AnyView(URLEncodingView())),
                Product(name: "JWT", detailView: AnyView(JWTEncodingView()))
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
                Product(name: "ChinaCore", detailView: AnyView(ChinaCoreView())),
                Product(name: "PolybiusCipher", detailView: AnyView(PolybiusCipherView()))
            ]
        case .text:
            [
                Product(name: "RegexTester", detailView: AnyView(RegexTesterView())),
                Product(name: "ZeroWidth", detailView: AnyView(ZeroWidthView())),
                Product(name: "CheckText", detailView: AnyView(CheckTextView()))
            ]
        case .image:
            [
                Product(name: "DropImage", detailView: AnyView(DropImageView())),
                Product(name: "QRCode", detailView: AnyView(QRCodeView()))
            ]
        case .finance:
            [
                Product(name: "Interest", detailView: AnyView(InterestView()))
            ]
        case .other:
            [
                Product(name: "Scan", detailView: AnyView(ScanView())),
                Product(name: "Spider", detailView: AnyView(SpiderView())),
                Product(name: "Exif", detailView: AnyView(ExifView()))
            ]
        }
    }
}
