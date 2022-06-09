//
//  TongCarPoolApp.swift
//  Shared
//
//  Created by Vozeo on 2022/6/1.
//

import SwiftUI
import CryptoKit

extension String {
var MD5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}

@main
struct TongCarPoolApp: App {
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
