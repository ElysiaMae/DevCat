//
//  DevCatApp.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import SwiftUI

@main
struct DevCatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.automatic)
        .windowToolbarStyle(.automatic)
        .commands {}

        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif

//        CommandGroup(replacing: .appSettings) {
//            Button("menu.settings") {}
//                .keyboardShortcut(",", modifiers: .command)
//        }
    }
}
