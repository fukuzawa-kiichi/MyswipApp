//
//  LikedTableViewController.swift
//  MyswipApp
//
//  Created by VERTEX24 on 2019/08/10.
//  Copyright © 2019 VERTEX24. All rights reserved.
//

import UIKit

class LikedTableViewController: UITableViewController {
    
    // いいねした名前の一覧の箱
    var likedName: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // いいねされたユーザーの数
        return likedName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // いいねされた名前の表示
        cell.textLabel?.text = likedName[indexPath.row]
        
        return cell
    }
    


}
