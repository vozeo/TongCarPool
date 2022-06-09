//
//  Network.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/8.
//

import Foundation
import SwiftUI

let rootURL: String = "https://huaweicloud.gardilily.com/"

func getRequest(subURL: String) -> URLRequest {
    var request = URLRequest(url: URL(string: rootURL + subURL)!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
}

func postRequest(subURL: String) -> URLRequest {
    var request = URLRequest(url: URL(string: rootURL + subURL)!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
}


