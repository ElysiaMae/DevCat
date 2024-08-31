//
//  Format.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/17.
//

import Foundation

func formatJSON(_ json: Any) -> String? {
    do {
        let data = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        return String(data: data, encoding: .utf8)
    } catch {
        print("Error formatting JSON: \(error)")
        return nil
    }
}

func formatJSONString(_ jsonString: String) -> String? {
    guard let data = jsonString.data(using: .utf8) else { return nil }

    do {
        if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return formatJSON(jsonObject)
        }
    } catch {
        print("Error parsing JSON string: \(error)")
    }

    return nil
}
