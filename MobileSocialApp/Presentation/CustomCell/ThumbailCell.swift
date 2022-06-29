//
//  ThumbailCell.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/22/22.
//

import Foundation
import UIKit

class ThumbailCellViewModel {
    let downloadService = DownloadService.shared
    
    func downloadImage(_ userPhoto: Photo, _ completion: @escaping (UIImage?)->Void) {
        downloadService.getPhoto(userPhoto.url, completion)
    }
}

class ThumbailCell: UITableViewCell {
    static let id = "ThumbailCell"
    let stackView: UIStackView = {
        return UIStackView()
    }()

    let stackView1: UIStackView = {
        return UIStackView()
    }()
    
    let stackView2: UIStackView = {
        return UIStackView()
    }()
    
    let imageView1: CustomImageView = {
        return CustomImageView()
    }()
    
    let imageView2: CustomImageView = {
        return CustomImageView()
    }()
    
    let imageView3: CustomImageView = {
        return CustomImageView()
    }()
    
    let imageView4: CustomImageView = {
        return CustomImageView()
    }()
    
    let imageView5: CustomImageView = {
        return CustomImageView()
    }()
    
    var userPost: UserPost?
    var viewModel = ThumbailCellViewModel()
    let mainQueue = DispatchQueue.main
    
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
        imageView1.image = nil
        imageView1.richTag = nil
        imageView2.image = nil
        imageView2.richTag = nil
        imageView3.image = nil
        imageView3.richTag = nil
        imageView4.image = nil
        imageView4.richTag = nil
        imageView5.image = nil
        imageView5.richTag = nil
    }
    
    func setupViews() {
        selectionStyle = .none
        
        stackView.spacing = 1.0
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        contentView.addSubview(stackView)
        
        stackView1.spacing = 1.0
        stackView1.axis = .horizontal
        stackView1.distribution = .fillEqually
        stackView.addArrangedSubview(stackView1)
        
        stackView2.spacing = 1.0
        stackView2.axis = .horizontal
        stackView2.distribution = .fillEqually
        stackView.addArrangedSubview(stackView2)
        
        imageView1.contentMode = .scaleAspectFill
        imageView1.clipsToBounds = true
        stackView1.addArrangedSubview(imageView1)
        imageView2.contentMode = .scaleAspectFill
        imageView2.clipsToBounds = true
        stackView1.addArrangedSubview(imageView2)
        imageView3.contentMode = .scaleAspectFill
        imageView3.clipsToBounds = true
        stackView2.addArrangedSubview(imageView3)
        imageView4.contentMode = .scaleAspectFill
        imageView4.clipsToBounds = true
        stackView2.addArrangedSubview(imageView4)
        imageView5.contentMode = .scaleAspectFill
        imageView5.clipsToBounds = true
        stackView2.addArrangedSubview(imageView5)
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
    
    func configure(_ photo: Photo) {
        let availableViews = layoutForOnePhoto()
        for (_, photoView) in availableViews.enumerated() {
            photoView.richTag = "\(photo.id)"
            viewModel.downloadImage(photo, { [weak self] image in
                self?.mainQueue.async {
                    if photoView.richTag == "\(photo.id)" {
                        photoView.image = image
                    }
                }
            })
        }
    }
    
    func configure(_ userPost: UserPost) {
        self.userPost = userPost
        var availableViews: [CustomImageView] = []
        switch userPost.photos.count {
        case 0: availableViews = layoutForZeroPhoto()
        case 1: availableViews = layoutForOnePhoto()
        case 2: availableViews = layoutForTwoPhoto()
        case 3: availableViews = layoutForThreePhoto()
        case 4: availableViews = layoutForFourPhoto()
        default: availableViews = layoutForFivePhoto()
        }
        for (i, photoView) in availableViews.enumerated() {
            photoView.richTag = "\(userPost.id)"
            viewModel.downloadImage(userPost.photos[i], { [weak self] image in
                self?.mainQueue.async {
                    if photoView.richTag == "\(userPost.id)" {
                        photoView.image = image
                    }
                }
            })
            
        }
    }
    
    func layoutForZeroPhoto() -> [CustomImageView] {
        stackView.isHidden = true
        stackView1.isHidden = true
        imageView1.isHidden = true
        imageView2.isHidden = true
        stackView2.isHidden = true
        imageView3.isHidden = true
        imageView4.isHidden = true
        imageView5.isHidden = true
        return []
    }
    
    func layoutForOnePhoto() -> [CustomImageView] {
        stackView.isHidden = false
        stackView1.isHidden = false
        imageView1.isHidden = false
        imageView2.isHidden = true
        stackView2.isHidden = true
        imageView3.isHidden = true
        imageView4.isHidden = true
        imageView5.isHidden = true
        return [imageView1]
    }
    
    func layoutForTwoPhoto() -> [CustomImageView] {
        stackView.isHidden = false
        stackView1.isHidden = false
        imageView1.isHidden = false
        imageView2.isHidden = false
        stackView2.isHidden = true
        imageView3.isHidden = true
        imageView4.isHidden = true
        imageView5.isHidden = true
        return [imageView1, imageView2]
    }
    
    func layoutForThreePhoto() -> [CustomImageView] {
        stackView.isHidden = false
        stackView1.isHidden = false
        imageView1.isHidden = false
        imageView2.isHidden = true
        stackView2.isHidden = false
        imageView3.isHidden = false
        imageView4.isHidden = false
        imageView5.isHidden = true
        return [imageView1, imageView3, imageView4]
    }
    
    func layoutForFourPhoto() -> [CustomImageView] {
        stackView.isHidden = false
        stackView1.isHidden = false
        imageView1.isHidden = false
        imageView2.isHidden = true
        stackView2.isHidden = false
        imageView3.isHidden = false
        imageView4.isHidden = false
        imageView5.isHidden = false
        return [imageView1, imageView3, imageView4, imageView5]
    }
    
    func layoutForFivePhoto() -> [CustomImageView] {
        stackView.isHidden = false
        stackView1.isHidden = false
        imageView1.isHidden = false
        imageView2.isHidden = false
        stackView2.isHidden = false
        imageView3.isHidden = false
        imageView4.isHidden = false
        imageView5.isHidden = false
        return [imageView1, imageView2, imageView3, imageView4, imageView5]
    }
}
