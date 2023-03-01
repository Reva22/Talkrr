//
//  ChatPageViewController.swift
//  Talkrr
//
//  Created by Reva Tamaskar on 10/02/23.
//

import UIKit
import Firebase

class ChatPageViewController: UIViewController {
    
    var user : String?
    
    let tableView = UITableView()
    let enterMessage = UITextField()
    let enterMessageContainer = UIView()
    let sendButton = UIButton()
    let messageDB = Database.database().reference().child("Messages")

    var ref = DatabaseReference()
    private var _refHandle = DatabaseHandle()
    private var messages = [MessageModel]()
    private var new = [DataSnapshot]()
    
    deinit {
        self.ref.child("Messages").removeObserver(withHandle: _refHandle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButton))
        
        view.addSubview(tableView)
        tableView.separatorColor = .clear
        tableView.register(ChatViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        view.addSubview(enterMessageContainer)
        enterMessageContainer.backgroundColor = .white
        enterMessageContainer.layer.cornerRadius = 25
        enterMessageContainer.layer.borderColor = UIColor.black.cgColor
        enterMessageContainer.layer.borderWidth = 1
        enterMessageContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterMessageContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            enterMessageContainer.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            enterMessageContainer.heightAnchor.constraint(equalToConstant: 50),
            enterMessageContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(sendButton)
        let image = UIImage(systemName: "paperplane", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        sendButton.setImage(image, for: .normal)
        sendButton.addTarget(self, action: #selector(hitSendButton), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sendButton.rightAnchor.constraint(equalTo: enterMessageContainer.rightAnchor, constant: 0),
            sendButton.widthAnchor.constraint(equalToConstant: 75),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(enterMessage)
        enterMessage.delegate = self
        enterMessage.text = "Enter Message"
        enterMessage.textColor = .black
        enterMessage.keyboardType = .default
        enterMessage.addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        enterMessage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterMessage.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: 0),
            enterMessage.leftAnchor.constraint(equalTo: enterMessageContainer.leftAnchor, constant: 20),
            enterMessage.heightAnchor.constraint(equalToConstant: 50),
            enterMessage.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        getMessages()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    func getMessages() {
        
        messageDB.observe(.childAdded, with:
        { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            guard let message = snapshotValue["message"], let sender = snapshotValue["sender"], let reciever = snapshotValue["reciever"] else {return}
            if !((reciever == self.user && sender == Auth.auth().currentUser?.email) || (sender == self.user && reciever == Auth.auth().currentUser?.email)) {return}
            let isIncoming = ((sender == Auth.auth().currentUser?.email && reciever == self.user) ? false : true)
            let chatMessage = MessageModel.init(message: message, reciever: reciever, sender: sender, isIncoming: isIncoming)
            self.addNewRow(with: chatMessage)
        })
    }
    
    func addNewRow(with chatMessage: MessageModel) {
        self.tableView.beginUpdates()
        self.messages.append(chatMessage)
        let indexPath = IndexPath(row: self.messages.count-1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .top)
        scrollToBottom()
        self.tableView.endUpdates()
    }
    
    func scrollToBottom(isAnimated:Bool = true){
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.tableView.numberOfRows(inSection:  self.tableView.numberOfSections-1) - 1,
                section: self.tableView.numberOfSections - 1)
            if self.tableView.numberOfRows(inSection: self.tableView.numberOfSections - 1) > 0 {
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }

}

extension ChatPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatViewCell
        
        cell.configure(with: messages[indexPath.row])
        
        return cell
    }
}

extension ChatPageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let message = enterMessage.text else {return true}
        if message == "" {
            return true
        }
        
        let messageDict = ["sender": Auth.auth().currentUser?.email, "reciever": user, "message" : message]
        
        messageDB.childByAutoId().setValue(messageDict) { (error, reference) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            else {
                print("end editing")
                self.enterMessage.text = "Enter Message"
                self.view.endEditing(true)
            }
        }
        
        self.enterMessage.text = "Enter Message"
        self.enterMessage.textColor = .lightGray
        self.view.endEditing(true)
        
        return true
    }
}

extension ChatPageViewController {
    
    @objc func keyboardWillShow(_ sender: Notification) {
        let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let offset = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        
        if keyboardSize!.height == offset!.height {
            if self.view.frame.origin.y == 0.0 {
                UIView.animate(withDuration: 0.10, animations: {
                    self.view.frame.origin.y -= keyboardSize!.height
                })
            }
        }
        
        else {
            UIView.animate(withDuration: 0.0, animations: {
                self.view.frame.origin.y -=  offset!.height
            })
        }
    }
    
    @objc func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue

        self.view.frame.origin.y += keyboardSize!.height
    }
    
    @objc func hitSendButton() {
        print("hitsendbutton")
        let message = enterMessage.text
        if message == "" {
            self.view.endEditing(true)
        }
        
        let messageDict = ["sender": Auth.auth().currentUser?.email, "reciever": user, "message" : message]
        
        messageDB.childByAutoId().setValue(messageDict) { (error, reference) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            else {
                print("end editing")
                self.enterMessage.text = "Enter Message"
                self.view.endEditing(true)
            }
        }
       
        self.enterMessage.text = "Enter Message"
        self.enterMessage.textColor = .lightGray
        self.view.endEditing(true)
    }
    
    @objc func didBeginEditing(){
        enterMessage.text = ""
        enterMessage.textColor = .black
    }
    
}
