//
//  User.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/1.
//

import Foundation
import LoremSwiftum

struct User: Codable, Hashable {
    var username: String = ""
    var userid: Int? = 0
    var password: String? = ""
    var gender: String? = "3"
    var wechatid: String? = ""
    var show: Bool? = true
}

enum Gender: String, CaseIterable, Identifiable {
    case female, male, none, secret;
    var id: Self { self }
    var description: String {
        switch self {
        case .female: return "0"
        case .male: return "1"
        case .none: return "2"
        case .secret: return "3"
        }
    }
}

let genderName: [String:String] = ["0": "女", "1":"男", "2":"无性别", "3":"保密"]
let genderEnum: [String:String] = ["0": "female", "1":"male", "2":"none", "3":"secret"]

func generateUserList() -> [User] {
    var list: [User] = []
    let num = Int.random(in: 5...15)
    for _ in 1...num {
        list.append(User(username: Lorem.lastName, userid: 0, password: "", gender: String(Int.random(in: 0...3)), wechatid: Lorem.firstName, show: true))
    }
    return list
}

let testUser = User(username: "Vozeo", userid: 1, password: "abc123", gender: "1", wechatid: "vozeo")

let testUserList = [testUser, User(username: "Summer", userid: 2, password: "abc123", gender: "0", wechatid: "MostCute"), User(username: "FlowerBlack", userid: 3, password: "", gender: "3", wechatid: "Donno"), User(username: "🐷🐷", userid: 4, password: "", gender: "2", wechatid: "Handsome"), User(username: "Winter", userid: 2, password: "abc123", gender: "0", wechatid: "MostCute"), User(username: "FlowerWhite", userid: 3, password: "", gender: "3", wechatid: "Donno"), User(username: "🐖🐖", userid: 4, password: "", gender: "2", wechatid: "Handsome")]
