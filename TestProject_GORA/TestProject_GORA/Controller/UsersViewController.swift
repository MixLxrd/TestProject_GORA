//
//  UsersViewController.swift
//  TestProject_GORA
//
//  Created by Михаил on 19.08.2021.
//

import UIKit

class UsersViewController: UIViewController {
    
    private let networkDataFetcher = NetworkDataFetcher()
    
    var users: Users? {
        didSet {
            usersTableView.reloadData()
        }
    }
    
    private lazy var usersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.toAutoLayout()
        tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: String(describing: UsersTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        networkDataFetcher.fetchUsers() { response in
            guard let search = response else { return }
            self.users = search
        }
    }
    
}

extension UsersViewController {
    private func setupLayout() {
        title = "Users"
        view.addSubview(usersTableView)
        let constraints = [
            usersTableView.topAnchor.constraint(equalTo: view.topAnchor),
            usersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UsersTableViewCell.self), for: indexPath) as! UsersTableViewCell
        cell.textLabel?.text = users?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PhotosViewController()
        guard let userID = users?[indexPath.row].id else { return }
        vc.userID = userID
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
