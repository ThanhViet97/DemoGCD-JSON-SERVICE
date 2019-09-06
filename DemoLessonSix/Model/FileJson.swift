//
//  FileJson.swift
//  DemoLessonSix
//
//  Created by VietPhan on 9/5/19.
//  Copyright © 2019 Phan Thanh Việt. All rights reserved.
//

import Foundation

struct GithubData : Decodable {
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

func getInforList(onSuccess : @escaping (_ listInfor : [GithubData]?) -> Void )  {
    let jsonUrdString = "https://api.github.com/users/google/repos"
    
    guard let url = URL(string: jsonUrdString) else
    {return}
    URLSession.shared.dataTask(with: url) { (data, respont, erroi) in
        guard let data = data else { return }
        //
        //            let dataAsString = String(data: data,encoding: .utf8)
        //            print(dataAsString)
        do {
            let githubData = try JSONDecoder().decode([GithubData].self, from: data)
            onSuccess(githubData)
        } catch let jsonErr {
            print(jsonErr)
        }
        }.resume()
}
