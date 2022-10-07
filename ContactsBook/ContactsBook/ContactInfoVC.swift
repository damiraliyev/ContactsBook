//
//  ContactInfoVC.swift
//  ContactsBook
//
//  Created by Damir Aliyev on 06.10.2022.
//

import Foundation
import UIKit

class ContactInfoVC: UIViewController {
    let genderImageView = UIImageView()
    let contactName = UILabel()
    let phoneNumber = UILabel()
    let textMessage = CommunicationView(imageName: "message.fill", text: "text")
    let call = CommunicationView(imageName: "phone.fill", text: "phone")
    let video = CommunicationView(imageName: "video.fill", text: "video")
    let email = CommunicationView(imageName: "envelope.fill", text: "mail")
    let stackView = makeStackView(axis: .horizontal)
    
    let phoneInfoView = UIView()
    let cellPhoneLabel = UILabel()
    let phoneNumInView = UILabel()
    let stackForPhoneInfo = makeStackView(axis: .vertical)
    
    let addToFavoritesButton = makeButton(withText: "   Add to favorites")
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        layout()
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setup() {
        genderImageView.translatesAutoresizingMaskIntoConstraints = false
//        genderImageView.image = UIImage(named: "male")
        
        contactName.translatesAutoresizingMaskIntoConstraints = false
//        contactName.text = "User"
        contactName.font = UIFont.systemFont(ofSize: 26)
        
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.distribution = .fillEqually
//        stackView.alignment = .fill
        
        let communicationViews = [textMessage, call, video, email]
        for customView in communicationViews {
            customView.layer.cornerRadius = 5
            customView.backgroundColor = .systemGray5
        }
        
        phoneInfoView.translatesAutoresizingMaskIntoConstraints = false
        phoneInfoView.backgroundColor = .systemGray5
        phoneInfoView.layer.cornerRadius = 5
        
        cellPhoneLabel.translatesAutoresizingMaskIntoConstraints = false
        cellPhoneLabel.text = "cellular"
        cellPhoneLabel.font = UIFont.systemFont(ofSize: 13)
        
        phoneNumInView.translatesAutoresizingMaskIntoConstraints = false
//        phoneNumInView.text = "+7(707)707-77-77"
        phoneNumInView.font = UIFont.systemFont(ofSize: 15)
        
        
        addToFavoritesButton.backgroundColor = .systemGray5
//        addToFavoritesButton.titleLabel?.text = "   Add to favorites"
        addToFavoritesButton.layer.cornerRadius = 5
        addToFavoritesButton.contentHorizontalAlignment = .left
        addToFavoritesButton.setTitleColor(.systemBlue, for: .normal)
        addToFavoritesButton.addTarget(self, action: #selector(addToFavoritePressed), for: .primaryActionTriggered)
    }
    
    
    func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(textMessage)
        stackView.addArrangedSubview(call)
        stackView.addArrangedSubview(video)
        stackView.addArrangedSubview(email)
        
        view.addSubview(genderImageView)
        view.addSubview(contactName)
        
        view.addSubview(phoneInfoView)
        phoneInfoView.addSubview(stackForPhoneInfo)
        stackForPhoneInfo.addArrangedSubview(cellPhoneLabel)
        stackForPhoneInfo.addArrangedSubview(phoneNumInView)
        
        view.addSubview(addToFavoritesButton)
        
        NSLayoutConstraint.activate([
            genderImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            genderImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            genderImageView.widthAnchor.constraint(equalToConstant: 120),
            genderImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            contactName.topAnchor.constraint(equalTo: genderImageView.bottomAnchor, constant: 8),
            contactName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contactName.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -8)
        ])
        
        NSLayoutConstraint.activate([
            phoneInfoView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            phoneInfoView.heightAnchor.constraint(equalToConstant: 65),
            phoneInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            phoneInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            stackForPhoneInfo.centerYAnchor.constraint(equalTo: phoneInfoView.centerYAnchor),
            stackForPhoneInfo.leadingAnchor.constraint(equalTo: phoneInfoView.leadingAnchor, constant: 14)
           
        ])
        
        NSLayoutConstraint.activate([
            addToFavoritesButton.topAnchor.constraint(equalTo: phoneInfoView.bottomAnchor, constant: 16),
            addToFavoritesButton.leadingAnchor.constraint(equalTo: phoneInfoView.leadingAnchor),
            addToFavoritesButton.trailingAnchor.constraint(equalTo: phoneInfoView.trailingAnchor)
        ])
    }
    
    func setContactInfo(gender: String, name: String, number: String) {
        genderImageView.image = UIImage(named: gender)
        contactName.text = name
        phoneNumber.text = number
        
        phoneNumInView.text = number
    }
    
    @objc func addToFavoritePressed() {
        addToFavoritesButton.alpha = 0.6
        
        UIView.animate(withDuration: 0.2) {
            self.addToFavoritesButton.alpha = 1
        }

    }
    
    
}
