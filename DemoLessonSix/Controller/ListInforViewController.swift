//
//  ListInforViewController.swift
//  DemoLessonSix
//
//  Created by VietPhan on 9/6/19.
//  Copyright © 2019 Phan Thanh Việt. All rights reserved.
//

import UIKit

class ListInforViewController: UIViewController {

// MARK: - Variable
    var githubData: [GithubData]!
    
// MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getInforList { (githubData) in
            self.githubData = githubData!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
extension ListInforViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return githubData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListInforTableViewCell.indentifier, for: indexPath) as! ListInforTableViewCell
        cell.ContentLable.text = githubData[indexPath.row].node_id
        cell.IDLable.text = String(githubData[indexPath.row].id!)
        return cell
    }
}
