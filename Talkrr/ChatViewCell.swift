//
//  ChatViewCell.swift
//  Talkrr
//
//  Created by Reva Tamaskar on 10/02/23.
//
import Foundation
import UIKit


class ChatViewCell: UITableViewCell {
    
    let messageLabel = UILabel()
    let messageBgView = UIView()
    
    var incomingConstraint = NSLayoutConstraint()
    var outgoingConstraint = NSLayoutConstraint()

    var isIncoming: Bool = false {
        didSet {
            messageBgView.backgroundColor = isIncoming ? #colorLiteral(red: 0.8604257107, green: 0.8679503798, blue: 1, alpha: 1) : #colorLiteral(red: 0.05237350613, green: 0.05283132941, blue: 0.06162492931, alpha: 1)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(messageBgView)
        addSubview(messageLabel)
        messageBgView.translatesAutoresizingMaskIntoConstraints = false
        messageBgView.layer.cornerRadius = 7
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        incomingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32.0)
        outgoingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32.0)
        
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            messageLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.75),
            
            incomingConstraint,
            outgoingConstraint,
            
            messageBgView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            messageBgView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            messageBgView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            messageBgView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)
        ]
        
        
        NSLayoutConstraint.activate(constraints)

        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(with model: MessageModel) {
        let message = NSMutableAttributedString(string: model.message)

        isIncoming = model.isIncoming
        if isIncoming {
            outgoingConstraint.priority = .defaultLow
            incomingConstraint.priority = .defaultHigh
                        
            messageLabel.attributedText = message
           
        }
        else {
            incomingConstraint.priority = .defaultLow
            outgoingConstraint.priority = .defaultHigh
            
            messageLabel.textColor = .white
            messageLabel.attributedText = message
        }
    }
}
