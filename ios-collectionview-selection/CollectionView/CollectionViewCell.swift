//
//  CollectionViewCell.swift
//  ios-collectionview-selectionShapeView
//
//  Created by yuki.yoshioka on 2019/12/03.
//  Copyright © 2019 rikusouda. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedFrameView: RectangleView!
    @IBOutlet weak var highlightView: UIView!
    
    // 選択状態の表示にselectedBackgroundViewを使うか自前Viewを使うかを切り替えられる
    let useSelectedBackgroundView = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectedFrameView.isHidden = true
        self.highlightView.alpha = 0
        
        if useSelectedBackgroundView {
            let selectedBackgroundView = RectangleView()
            selectedBackgroundView.fillColor = .clear
            selectedBackgroundView.borderColor = .systemRed
            selectedBackgroundView.borderWidth = 3
            self.selectedBackgroundView = selectedBackgroundView
        }
    }
    
    func inject(element: CollectionElement) {
        self.titleLabel.text = element.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override var isSelected: Bool {
        didSet {
            if !self.useSelectedBackgroundView {
                // セルの選択状態変化に応じて表示を切り替える
                self.selectedFrameView.isHidden = !self.isSelected
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if !self.useSelectedBackgroundView {
                // セルの押している最中だけ表示を切り替える
                UIView.animate(withDuration: 0.1) {
                    self.highlightView.alpha = self.isHighlighted ? 0.3 : 0.0
                }
            }
        }
    }
}
