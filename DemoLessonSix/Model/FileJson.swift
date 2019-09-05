//
//  FileJson.swift
//  DemoLessonSix
//
//  Created by VietPhan on 9/5/19.
//  Copyright © 2019 Phan Thanh Việt. All rights reserved.
//

import Foundation

struct GithubData:Decodable {
    var id : Int?
    var node_id : String?
    var name : String?
    var full_name : String?
    var owner : Owner?
    var html_url : String?
//
//    init(json: [String: Any]) {
//        id = json["id"] as? Int ?? 1
//        node_id = json["node_id"] as? String ?? ""
//        name = json["name"] as? String ?? ""
//        full_name = json["full_name"] as? String ?? ""
//        owner = json["owner"] as? Array ?? []
//        html_url = json["html_url"] as? String ?? ""
//    }
}

struct Owner: Decodable {
    var login: String?
    var id : Int?
    var gravatar_id : String?
}
