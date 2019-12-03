//
//  CollectionViewController.swift
//  ios-collectionview-selection
//
//  Created by yuki.yoshioka on 2019/12/03.
//  Copyright © 2019 rikusouda. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var elements: [CollectionElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        for index in 1 ... 20 {
            elements.append(CollectionElement.init(id: index, title: "\(index)"))
        }
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.collectionView.dataSource = self
        
        // セルの複数選択を許可する
        self.collectionView.allowsMultipleSelection = true
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.inject(element: self.elements[indexPath.row])
        return cell
    }
}

