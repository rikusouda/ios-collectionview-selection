//
//  TableViewCell.swift
//  ios-collectionview-selection
//
//  Created by yuki.yoshioka on 2019/12/03.
//  Copyright © 2019 rikusouda. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    private var highlightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // タップ中のセルをハイライトするための自前Viewを追加
        // contentViewに入れるとaccessoryの背面やEdit中のチェックマークの背面に表示されないので、あえてselfの直下に追加
        self.highlightView = UIView()
        self.highlightView.backgroundColor = .systemYellow
        self.addSubview(self.highlightView)
        self.highlightView.translatesAutoresizingMaskIntoConstraints = false
        self.highlightView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.highlightView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.highlightView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.highlightView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.highlightView.alpha = 0
        
        // Edit時のチェックマークの色を変える
        self.tintColor = .systemOrange
        
        // Edit時にselectionStyleをdefaultにする
        // その時の選択セルの背景色を無効にする
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .clear
        self.selectedBackgroundView = selectedBackgroundView
    }
    
    func inject(element: CollectionElement) {
        self.textLabel?.text = element.title
    }
    
    override var isSelected: Bool {
        didSet {
            // セルの選択状態変化に応じて表示を切り替える
            self.onUpdateSelection()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        // ユーザー操作の場合はisSelectedのdidSetは呼び出されずこちらが呼び出される
        super.setSelected(selected, animated: animated)
        self.onUpdateSelection()
    }
    
    private func onUpdateSelection() {
        self.accessoryType = self.isSelected ? .checkmark : .none
    }
    
    override var isHighlighted: Bool {
        didSet {
            // セルを押している最中だけ表示を切り替える
            self.onUpdateHighlight(self.isHighlighted, animated: false)
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        // ユーザー操作の場合はisHighlightedのdidSetは呼び出されずこちらが呼び出される
        super.setHighlighted(highlighted, animated: animated)
        self.onUpdateHighlight(highlighted, animated: animated)
    }
    
    private func onUpdateHighlight(_ highlighted: Bool, animated: Bool) {
        UIView.animate(withDuration: animated ? 0.1 : 0) {
            self.highlightView.alpha = highlighted ? 0.3 : 0.0
        }
    }
    
    override var isEditing: Bool {
        didSet {
            self.onEdigingChanged(self.isEditing, animated: false)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        // ユーザー操作の場合はisEditingのdidSetは呼び出されずこちらが呼び出される
        super.setEditing(editing, animated: animated)
        self.onEdigingChanged(editing, animated: animated)
    }
    
    private func onEdigingChanged(_ editing: Bool, animated: Bool) {
        // selectionStyleがnoneだとEdit中のチェックマークが選択状態にならないので、Edit中だけdefaultに変更する
        self.selectionStyle = editing ? .default : .none
    }
}
