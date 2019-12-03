//
//  TableViewSelectionViewController.swift
//  ios-collectionview-selection
//
//  Created by yuki.yoshioka on 2019/12/03.
//  Copyright © 2019 rikusouda. All rights reserved.
//

import Foundation
import UIKit

class TableViewSelectionViewController: UITableViewController {
    var elements: [CollectionElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        for index in 1 ... 50 {
            elements.append(CollectionElement.init(id: index, title: "\(index)"))
        }
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        // Edit状態ではないときに複数選択を許可する
        self.tableView.allowsMultipleSelection = true
        
        // Edit状態のときに複数選択を許可する
        // これを設定すると左側に自動でチェックマークが表示される
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    @IBAction func onEdit(_ sender: Any) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.inject(element: self.elements[indexPath.row])
        return cell
    }
}
