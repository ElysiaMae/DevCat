//
//  JWTEncodingView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/16.
//

import Foundation
import Sisyphus
import SwiftUI

struct JWTEncodingView: View {
    @State private var secret = "your-256-bit-secret"
    @State private var payloadString = ""

    @State private var encodedJWT: String = ""
    @State private var decodedHeader: [String: Any] = [:]
    @State private var decodedPayload: [String: Any] = [:]
    @State private var decodedSignature: String = ""

    @State private var algorithmType: [String] = ["HS256", "HS384", "HS512"]
    @State private var selectedAlgorithmType: JWTAlgorithm = .HS256

    @State private var header: String = #"{"alg":"HS256","typ":"JWT"}"#
    @State private var payload: String = #"{"sub": "1234567890","name": "John Doe","iat": 1516239022}"#
    @State private var jwtString: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"

    @State private var inputText1 = ""

//    private var jwt= new JWT()

    var body: some View {
        VStack {
            TitleText("JWT Encoding")
            HStack {
                Picker("Algorithm:", selection: $selectedAlgorithmType) {
                    ForEach(JWTAlgorithm.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
            }
            Spacer()
            HStack {
                VStack {
                    Text("Encoded")
                    MonoTextEditor(text: $jwtString)
                }
                .padding()
                .onChange(of: jwtString) { _, newValue in
                    let jwt = JWT(secret: secret, algorithm: selectedAlgorithmType)
                    let ans = jwt.decode(jwt: newValue)
                    do {
                        let headerData = try JSONSerialization.data(withJSONObject: ans?.header ?? "", options: .prettyPrinted)

                        if let headerString = String(data: headerData, encoding: .utf8) {
                            header = headerString
                        }

                        let payloadData = try JSONSerialization.data(withJSONObject: ans?.payload ?? "", options: .prettyPrinted)

                        if let payloadString = String(data: payloadData, encoding: .utf8) {
                            payload = payloadString
                        }

                    } catch {
                        print("Error converting dictionary to JSON: \(error)")
                    }
                }
                VStack {
                    Text("Decoded")

                    Text("Header")
                    MonoTextEditor(text: $header)
                    Text("Payload")
                    MonoTextEditor(text: $payload)
                    Text("Verify Signature")
                    MonoTextEditor(text: $header)
                }
                .padding()
                .onChange(of: header) { oldValue, newValue in
                    header = formatJSONString(newValue) ?? oldValue
                }
                .onChange(of: payload) { oldValue, newValue in
                    payload = formatJSONString(newValue) ?? oldValue
                }
            }
        }.padding()
    }
}

#Preview {
    JWTEncodingView()
        .environment(\.locale, .init(identifier: "zh-Hant"))
}
