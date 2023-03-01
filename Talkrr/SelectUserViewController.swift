//
//  SearchUserViewController.swift
//  Talkrr
//
//  Created by Reva Tamaskar on 10/02/23.
//

import Foundation
import UIKit
import Firebase

class SelectUserViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var users = [Users]()
    var filteredUsers = [Users]()
    var isSearch : Bool = false

    let messageDB = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButton))
        
        self.view.backgroundColor = .systemBackground

        self.view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -5),
            searchBar.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 5),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 70),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        filteredUsers = users
        
        fetchUser()
        
    }
    
    func fetchUser() {
        messageDB.child("Users").observe(.childAdded, with:
        { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            guard let email = snapshotValue["email"], let name = snapshotValue["username"] else {return}
            let user = Users.init(email: email, name: name)
            self.users.append(user)
            self.filteredUsers.append(user)
            self.tableView.reloadData()
            
        }, withCancel: nil)
    }
}

extension SelectUserViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let user = filteredUsers[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVC = ChatPageViewController()
        rootVC.user = filteredUsers[indexPath.row].email
        rootVC.title = "\(filteredUsers[indexPath.row].name)"
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}

extension SelectUserViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUsers = searchText.isEmpty ? users: users.filter { user in
            return user.name.hasPrefix(searchText)
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

extension SelectUserViewController {
    
    @objc func didTapView(){
        self.view.endEditing(true)
    }
   
    @objc func backButton() {
        dismiss(animated: true, completion: nil)
    }

}
