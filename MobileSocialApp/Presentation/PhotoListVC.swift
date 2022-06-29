//
//  PhotoListVC.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/26/22.
//

import Foundation
import UIKit

enum PhotoRow: Int, CaseIterable {
    case PHOTO
    case CAPTION
    case BUTTON
}

class PhotoListViewModel {
    var userPost: UserPost?
    func configure(_ userPost: UserPost) {
        self.userPost = userPost
    }
    
    func getUserPhotoCount() -> Int {
        guard let userPost = userPost else {
            return 0
        }
        return userPost.photos.count + 1
    }
    
    func getUserPhoto(_ photoIndex: Int) -> Photo? {
        guard let userPost = userPost,
              photoIndex > 0,
              (photoIndex - 1) < userPost.photos.count else {
            return nil
        }
        return userPost.photos[photoIndex - 1]
    }
}

class PhotoListVC: UIViewController {
    var viewModel = PhotoListViewModel()
    
    lazy var tableView: UITableView = {
        return CustomTableView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAutolayouts()
        setupDelegates()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.title = nil
    }
    
    func setupViews() {
        view.addSubview(tableView)
    }
    
    func setupAutolayouts() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0)
        ])
    }
    
    func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configure(_ userPost: UserPost) {
        viewModel.configure(userPost)
    }
}

extension PhotoListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = PhotoRow(rawValue: section % PhotoRow.allCases.count)
        switch section {
        case .BUTTON:
            return 10.0
        default:
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: ClearFooter.id)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getUserPhotoCount() * PhotoRow.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = PhotoRow(rawValue: indexPath.section % PhotoRow.allCases.count)
        let photo = viewModel.getUserPhoto(indexPath.section / PhotoRow.allCases.count)
        switch section {
        case .PHOTO:
            return photo == nil ? 50.0 : 200.0
        case .CAPTION:
            return UITableView.automaticDimension
        case .BUTTON:
            return 50
        case .none:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userPost = viewModel.userPost else { return UITableViewCell() }
        let section = PhotoRow(rawValue: indexPath.section % PhotoRow.allCases.count)
        let photo = viewModel.getUserPhoto(indexPath.section / PhotoRow.allCases.count)
        switch section {
        case .PHOTO:
            if let photo = photo {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ThumbailCell.id, for: indexPath) as? ThumbailCell else {
                    return UITableViewCell()
                }
                cell.configure(photo)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTopCell.id, for: indexPath) as? PostTopCell else {
                    return UITableViewCell()
                }
                cell.configure(userPost)
                return cell
            }
        case .CAPTION:
            guard let photo = photo else {
                return UITableViewCell()
            }

            guard let cell = tableView.dequeueReusableCell(withIdentifier: CaptionCell.id, for: indexPath) as? CaptionCell else {
                return UITableViewCell()
            }
            cell.configure(photo)
            return cell
        case .BUTTON:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.id, for: indexPath) as? ButtonCell else {
                return UITableViewCell()
            }
            cell.configure(userPost)
            return cell
        case .none:
            return UITableViewCell()
        }
    }
}
