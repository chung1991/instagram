//
//  ClearFooter.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/23/22.
//

import Foundation
import UIKit

class ClearFooter: UITableViewHeaderFooterView {
    static let id = "ClearFooter"
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let view = UIView()
        view.backgroundColor = .clear
        backgroundView = view // ask
        //print ("Vao")
    }
}
