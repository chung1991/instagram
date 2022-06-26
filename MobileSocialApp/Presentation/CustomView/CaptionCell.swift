//
//  CaptionCell.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/23/22.
//

import Foundation
import UIKit

class CaptionCell: UITableViewCell {
    static let id = "CaptionCell"
    
    lazy var captionLabel: UILabel = {
        return UILabel()
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
        captionLabel.text = nil
    }
    
    func setupViews() {
        captionLabel.numberOfLines = 3
        captionLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        captionLabel.textAlignment = .left
        contentView.addSubview(captionLabel)
    }
    
    func setupAutolayouts() {
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            captionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
            captionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0)
        ])
    }
    
    func configure(_ userPost: UserPost) {
        captionLabel.text = userPost.caption
    }
}
