//
//  ContactCell.swift
//  ContactsBook
//
//  Created by Damir Aliyev on 02.10.2022.
//

import Foundation
import UIKit

//struct ContactModel {
//    let gender: String
//    let contactName: String
//    let phoneNumber: String
//}

class ContactCell: UITableViewCell {
    
    
    static let reuseID = "ContactCell"
    let stackView = UIStackView()
    
    let myImageView = UIImageView()
    let contactName = UILabel()
    let phoneNumber = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
        
    }
    
    func setup() {
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
//        stackView.alignment = .center
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.image = UIImage(named: "male")
    
        
        contactName.translatesAutoresizingMaskIntoConstraints = false
        contactName.text = "Cristiano Ronaldo"
        contactName.adjustsFontSizeToFitWidth = true
        
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.text = "+7 777 777 77 77"
        phoneNumber.font = UIFont.systemFont(ofSize: 14)
        phoneNumber.adjustsFontSizeToFitWidth = true
    }
    
    func layout() {
        addSubview(myImageView)
        addSubview(stackView)
        
        stackView.addArrangedSubview(contactName)
        stackView.addArrangedSubview(phoneNumber)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            myImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            myImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            myImageView.heightAnchor.constraint(equalToConstant: 50),
            myImageView.widthAnchor.constraint(equalToConstant: 50),
            
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
            
//            contactName.centerXAnchor.constraint(equalTo: centerXAnchor),
//            contactName.centerYAnchor.constraint(equalTo: myImageView.centerYAnchor),
//
//            phoneNumber.topAnchor.constraint(equalTo: contactName.bottomAnchor, constant: 4),
//            phoneNumber.centerXAnchor.constraint(equalTo: contactName.centerXAnchor)
        ])
    }
    
    func configureCell(model: Contact) {
        myImageView.image = UIImage(named: model.gender!)
        contactName.text = model.contactName
        phoneNumber.text = model.phoneNumber
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func makeStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = axis
    stackView.spacing = 8
    
    return stackView
}
