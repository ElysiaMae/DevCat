//
//  AppSettings.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/8/30.
//

import Foundation
import SwiftUI

enum AppSettingsKeys {
    static let monoFontName = "monoFontName"
    static let monoPointSize = "monoPointSize"
}

// 已知问题，不能及时刷新，也有可能是我的实现方法有问题
//enum AppSettings {
//    static let monoFontName = AppStorage(wrappedValue: "JetBrains Mono", AppSettingsKeys.monoFontName)
//    static let monoPointSize = AppStorage(wrappedValue: CGFloat(12), AppSettingsKeys.monoPointSize)
//}

// class AppSettings: ObservableObject {
//    @AppStorage(AppSettingsKeys.monoFontName) public var monoFontName = "JetBrains Mono"
//    @AppStorage(AppSettingsKeys.monoPointSize) public var monoPointSize = CGFloat(14)
//
////    public static let shared = AppSettings()
// }
