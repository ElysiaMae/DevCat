//
//  RegexTesterView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import SwiftUI

struct RegexTesterView: View {
    @State private var regexPattern: String = ""
    @State private var testString: String = ""
    @State private var result: String = ""
    var body: some View {
        VStack {
            HStack {
                Text("Regex Pattern:")
                    .frame(width: 100, alignment: .leading)
                Spacer()
                MonoTextField(text: $regexPattern)
            }
            Spacer()
            HStack {
                Text("Test String:")
                    .frame(width: 100, alignment: .leading)
                Spacer()
                MonoTextField(text: $regexPattern)
            }
            Spacer()
        
            Button("Test Regex", action: {
                result = testRegex()
            })
            Spacer()
            
            Text("Result: \(result)")
                .padding()
        }
        .padding()
    }
    
    func testRegex() -> String {
        do {
            let regex = try NSRegularExpression(pattern: regexPattern)
            let range = NSRange(location: 0, length: testString.utf16.count)
            let matches = regex.matches(in: testString, range: range)
            
            if matches.isEmpty {
                return "No match found."
            } else {
                return "\(matches.count) match(es) found."
            }
        } catch {
            return "Invalid regular expression pattern."
        }
    }
}

#Preview {
    RegexTesterView()
}
