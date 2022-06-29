//
//  CustomTableView.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/26/22.
//

import Foundation
import UIKit

class CustomTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor(displayP3Red: 160.0/255.0,
                                  green: 164.0/255.0,
                                  blue: 166.0/255.0,
                                  alpha: 1.0)
        allowsSelection = true
        separatorStyle = .none
        register(ThumbailCell.self, forCellReuseIdentifier: ThumbailCell.id)
        register(PostTopCell.self, forCellReuseIdentifier: PostTopCell.id)
        register(CaptionCell.self, forCellReuseIdentifier: CaptionCell.id)
        register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.id)
        register(ClearFooter.self, forHeaderFooterViewReuseIdentifier: ClearFooter.id)
    }
}
