//
//  ButtonCell.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/23/22.
//

import Foundation
import UIKit

class ButtonCell: UITableViewCell {
    static let id = "ButtonCell"
    let stackView: UIStackView = {
        return UIStackView()
    }()

    let button1: UIButton = {
        return UIButton()
    }()
    
    let button2: UIButton = {
        return UIButton()
    }()
    
    let button3: UIButton = {
        return UIButton()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupAutolayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        button1.setTitle(nil, for: .normal)
        button1.setImage(nil, for: .normal)
        button2.setTitle(nil, for: .normal)
        button2.setImage(nil, for: .normal)
        button3.setTitle(nil, for: .normal)
        button3.setImage(nil, for: .normal)
    }
    
    func setupViews() {
        selectionStyle = .none
        
        stackView.spacing = 1.0
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        contentView.addSubview(stackView)
        
        button1.tintColor = .label
        button1.setTitleColor(.label, for: .normal)
        stackView.addArrangedSubview(button1)
        button2.tintColor = .label
        button2.setTitleColor(.label, for: .normal)
        stackView.addArrangedSubview(button2)
        button3.tintColor = .label
        button3.setTitleColor(.label, for: .normal)
        stackView.addArrangedSubview(button3)
    }
    
    func setupAutolayouts() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0)
        ])
    }
    
    func configure(_ userPost: UserPost) {
        button1.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        button1.setTitle("42", for: .normal)
        
        button2.setImage(UIImage(systemName: "message"), for: .normal)
        button2.setTitle("5", for: .normal)
        
        button3.setImage(UIImage(systemName: "arrowshape.turn.up.forward"), for: .normal)
        button3.setTitle("1", for: .normal)
        
    }
}

