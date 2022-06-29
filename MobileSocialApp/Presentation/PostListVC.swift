//
//  PostListVC.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/19/22.
//

// features
// load 20 post initially
// scroll to load more




// 2
// 4
// 1
// 3


import UIKit

enum PostRow: Int, CaseIterable {
    case TOP
    case CAPTION
    case PHOTO
    case BUTTON
}

protocol PostListViewModelDelegate: AnyObject {
    func userPostUpdated()
}

class PostListViewModel {
    let globalQueue = DispatchQueue.global()
    var userPost: [UserPost] = [] {
        didSet {
            delegate?.userPostUpdated()
        }
    }
    var postService = PostService()
    weak var delegate: PostListViewModelDelegate?
    
    func load() {
        let now = Date()
        globalQueue.async { [weak self] in
            guard let self = self else { return }
            self.userPost = self.postService.getPosts()
            print ("load takes", Date().timeIntervalSince(now), "seconds")
        }
    }
}

protocol PostListVCDelegate: AnyObject {
    func didTapPhotoDetails(_ userPost: UserPost)
}

class PostListVC: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = CustomTableView()
        return tableView
    }()
    
    let viewModel = PostListViewModel()
    let mainQueue = DispatchQueue.main
    weak var delegate: PostListVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAutolayouts()
        setupDelegates()
        viewModel.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.title = nil
    }

    func setupViews() {
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

extension PostListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = PostRow(rawValue: section % PostRow.allCases.count)
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
        return viewModel.userPost.count * PostRow.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = PostRow(rawValue: indexPath.section % PostRow.allCases.count)
        switch section {
        case .TOP:
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = PostRow(rawValue: indexPath.section % PostRow.allCases.count)
        let userPost = viewModel.userPost[indexPath.section / PostRow.allCases.count]
        switch section {
        case .PHOTO:
            delegate?.didTapPhotoDetails(userPost)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = PostRow(rawValue: indexPath.section % PostRow.allCases.count)
        let userPost = viewModel.userPost[indexPath.section / PostRow.allCases.count]
        switch section {
        case .TOP:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTopCell.id, for: indexPath) as? PostTopCell else {
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ThumbailCell.id, for: indexPath) as? ThumbailCell else {
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

extension PostListVC: PostListViewModelDelegate {
    func userPostUpdated() {
        mainQueue.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
