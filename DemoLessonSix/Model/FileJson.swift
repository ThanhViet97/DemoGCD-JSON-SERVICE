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
    var nodeId : String?
    var name : String?
    var fullName : String?
    var owner : Owner?
    var htmlUrl : String?
//
//    init(json: [String: Any]) {
//        id = json["id"] as? Int ?? 1
//        nodeId = json["node_id"] as? String ?? ""
//        name = json["name"] as? String ?? ""
//        full_name = json["full_name"] as? String ?? ""
//        owner = json["owner"] as? Array ?? []
//        html_url = json["html_url"] as? String ?? ""
//    }
}

struct Owner: Decodable {
    var login: String?
    var id : Int?
    var gravatarId : String?
    
    
}

func getInforList(onSuccess : @escaping (_ listInfor : [GithubData]?) -> Void )  {
    let jsonUrdString = "https://api.github.com/users/google/repos"
    
    guard let url = URL(string: jsonUrdString) else
    {return}
    URLSession.shared.dataTask(with: url) { (data, respont, err) in
        guard let data = data else { return }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let githubData = try decoder.decode([GithubData].self, from: data)
            onSuccess(githubData)
            
        } catch let jsonErr {
            print(jsonErr)
        }
        }.resume()
}
