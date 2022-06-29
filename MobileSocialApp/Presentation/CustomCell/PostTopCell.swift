//
//  AvatarCell.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/23/22.
//

import Foundation
import UIKit

struct PostTopCellViewModel {
    let dateService = DateService()
    func getDateDisplay(_ date1: Date, _ date2: Date) -> String {
        let gap = dateService.getGapBetween(date1, date2)
        return "\(gap)d"
    }
}

class PostTopCell: UITableViewCell {
    static let id = "PostTopCell"
    
    lazy var avatarImageView: UIImageView = {
        return UIImageView()
    }()
    
    lazy var nameLabel: UILabel = {
        return UILabel()
    }()
    
    lazy var createdLabel: UILabel = {
        return UILabel()
    }()
    
    lazy var viewModel = PostTopCellViewModel()
    
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
        avatarImageView.image = nil
        nameLabel.text = nil
        createdLabel.text = nil
    }
    
    func setupViews() {
        selectionStyle = .none
        
        avatarImageView.contentMode = .scaleAspectFit
        contentView.addSubview(avatarImageView)
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        nameLabel.textAlignment = .left
        
        contentView.addSubview(nameLabel)
        
        createdLabel.font = .systemFont(ofSize: 12, weight: .light)
        createdLabel.textAlignment = .left
        contentView.addSubview(createdLabel)
    }
    
    func setupAutolayouts() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            avatarImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
            avatarImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 0)
        ])
        
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createdLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            createdLabel.topAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 0)
        ])
    }
    
    func configure(_ userPost: UserPost) {
        avatarImageView.image = UIImage(systemName: "person.crop.circle")
        nameLabel.text = userPost.userName
        createdLabel.text = viewModel.getDateDisplay(userPost.postDate, Date())
    }
}
