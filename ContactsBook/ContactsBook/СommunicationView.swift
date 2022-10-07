//
//  СommunicationView.swift
//  ContactsBook
//
//  Created by Damir Aliyev on 06.10.2022.
//

import Foundation
import UIKit

class CommunicationView: UIView {
    let ownImageView = UIImageView()
    let label = UILabel()
    let stackView = makeStackView(axis: .vertical)
    init(imageName: String, text: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        ownImageView.image = UIImage(systemName: imageName)
        label.text = text
        
        setup()
        layout()
    }
    func setup() {
        ownImageView.translatesAutoresizingMaskIntoConstraints = false
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 11)
    }

    
    func layout() {
        addSubview(stackView)
        stackView.addArrangedSubview(ownImageView)
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 70, height: 55)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
