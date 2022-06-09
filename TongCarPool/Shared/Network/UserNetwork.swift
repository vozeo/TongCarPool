//
//  UserNetwork.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/8.
//

import Foundation

var loginUser: User = User()

struct LoginUserReq: Codable {
    var success: Bool
    var msg: String?
    var data: User?
}

@MainActor
func userPost(user: User, subURL: String) async -> Bool {
    var request = postRequest(subURL: "user/" + subURL)
    request.httpBody = try? JSONEncoder().encode(user)
    print(String(decoding: request.httpBody ?? Data(), as: UTF8.self))
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            let userResponse = try JSONDecoder().decode(LoginUserReq.self, from: data)
            print(userResponse)
            if userResponse.success {
                loginUser = userResponse.data ?? loginUser
                return true
            }
            return false
        }
        return false
    } catch {
        return false
    }
}
