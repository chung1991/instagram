//
//  ViewController.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/19/22.
//

import UIKit

enum FeedRow: Int, CaseIterable {
    case AVATAR
    case CAPTION
    case PHOTO
    case BUTTON
}

protocol ViewModelDelegate: AnyObject {
    func userPostUpdated()
}

class ViewModel {
    let globalQueue = DispatchQueue.global()
    var userPost: [UserPost] = [] {
        didSet {
            delegate?.userPostUpdated()
        }
    }
    var postService = PostService()
    weak var delegate: ViewModelDelegate?
    
    func load() {
        let now = Date()
        globalQueue.async { [weak self] in
            guard let self = self else { return }
            self.userPost = self.postService.getPosts()
            print ("load takes", Date().timeIntervalSince(now), "seconds")
        }
    }
}

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let viewModel = ViewModel()
    let mainQueue = DispatchQueue.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAutolayouts()
        setupDelegates()
        viewModel.load()
    }

    func setupViews() {
        tableView.backgroundColor = UIColor(displayP3Red: 160.0/255.0,
                                       green: 164.0/255.0,
                                       blue: 166.0/255.0,
                                       alpha: 1.0)
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.id)
        tableView.register(AvatarCell.self, forCellReuseIdentifier: AvatarCell.id)
        tableView.register(CaptionCell.self, forCellReuseIdentifier: CaptionCell.id)
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.id)
        tableView.register(ClearFooter.self, forHeaderFooterViewReuseIdentifier: ClearFooter.id)
        view.addSubview(tableView)
    }
    
    func setupAutolayouts() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupDelegates() {
        viewModel.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = FeedRow(rawValue: section % FeedRow.allCases.count)
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
        return viewModel.userPost.count * FeedRow.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = FeedRow(rawValue: indexPath.section % FeedRow.allCases.count)
        switch section {
        case .AVATAR:
            return 50.0
        case .CAPTION:
            return UITableView.automaticDimension
        case .PHOTO:
            return 200
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
        let section = FeedRow(rawValue: indexPath.section % FeedRow.allCases.count)
        let userPost = viewModel.userPost[indexPath.section / FeedRow.allCases.count]
        switch section {
        case .AVATAR:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AvatarCell.id, for: indexPath) as? AvatarCell else {
                return UITableViewCell()
            }
            cell.configure(userPost)
            return cell
        case .CAPTION:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CaptionCell.id, for: indexPath) as? CaptionCell else {
                return UITableViewCell()
            }
            cell.configure(userPost)
            return cell
        case .PHOTO:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.id, for: indexPath) as? PhotoCell else {
                return UITableViewCell()
            }
            cell.configure(userPost)
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

extension ViewController: ViewModelDelegate {
    func userPostUpdated() {
        mainQueue.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
