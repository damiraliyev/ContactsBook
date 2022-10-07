//
//  ContactVC.swift
//  ContactsBook
//
//  Created by Damir Aliyev on 05.10.2022.
//

import Foundation
import UIKit

protocol NewContactDelegate {
    func didSaveContact(name: String, number: String, gender: String)
}


class NewContactVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        nameTextField.text = ""
        numberTextField.text = ""
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    var newContactDelegate: NewContactDelegate!
    
    let nameTextField = makeTextField(placeholder: "Your name")
    var numberTextField = makeTextField(placeholder: "Phone number")
    let genderPickerView = UIPickerView()
    var saveButtonContainer = UIView()
    let genders = ["male", "female"]
    let nameErrorLabel = UILabel()
    let numberErrorLabel = UILabel()
    
    var name = String()
    var number = String()
    var gender = "male"
    
    
    var saveButtonBottomConstraint = NSLayoutConstraint()
    var nameTextFieldTopConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New contact"
        view.backgroundColor = .systemBackground
        saveButtonContainer = makeButtonCustomView()
        registerForNotificationChanges()
        setup()
        layout()
    }
    
    func registerForNotificationChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(NewContactVC.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func rotated() {
        
        if UIDevice.current.orientation.isLandscape {
            nameTextFieldTopConstraint.isActive = false
            nameTextFieldTopConstraint = nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
            nameTextFieldTopConstraint.isActive = true
            
            
            saveButtonBottomConstraint.isActive = false
            saveButtonBottomConstraint = saveButtonContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
            saveButtonBottomConstraint.isActive = true
        } else {
            nameTextFieldTopConstraint.isActive = false
            nameTextFieldTopConstraint = nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
            nameTextFieldTopConstraint.isActive = true
            
            saveButtonBottomConstraint.isActive = false
            saveButtonBottomConstraint = saveButtonContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
            
            saveButtonBottomConstraint.isActive = true
        }
        print("rotated!")
    }
    
    
    private func setup() {
        genderPickerView.translatesAutoresizingMaskIntoConstraints = false
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        
        nameTextField.delegate = self
        numberTextField.delegate = self
        
        gender = "male"
        
        setupErrorLabel(errorLabel: nameErrorLabel)
        setupErrorLabel(errorLabel: numberErrorLabel)
        
        setupDismissKeyboardGesture()
        
    }
    
    func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped() {
        view.endEditing(true) //resign the first responder
    }
    
    private func layout() {
        view.addSubview(nameTextField)
        view.addSubview(nameErrorLabel)
        view.addSubview(numberTextField)
        view.addSubview(numberErrorLabel)
        view.addSubview(genderPickerView)
        view.addSubview(saveButtonContainer)
        
        NSLayoutConstraint.activate([
            //nameTextField
//            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            //nameErrorLabel
            nameErrorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,constant: 8),
            nameErrorLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            
            //numberTextField
            numberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 32),
            numberTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            numberTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            //numberErrorlabel
            numberErrorLabel.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 8),
            numberErrorLabel.leadingAnchor.constraint(equalTo: numberTextField.leadingAnchor),
            
            
            //pickerView
            genderPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            genderPickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 24),
            genderPickerView.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 8),
            genderPickerView.heightAnchor.constraint(equalToConstant: 75),
            
            
            //saveButton
//            saveButton.topAnchor.constraint(equalTo: genderPickerView.bottomAnchor, constant: 16),
//            saveButtonContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            saveButtonContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            saveButtonContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        nameTextFieldTopConstraint = nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        nameTextFieldTopConstraint.isActive = true
        saveButtonBottomConstraint = saveButtonContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        saveButtonBottomConstraint.isActive = true
    }
    
    func makeButtonCustomView() -> UIView {
        let saveButton = makeButton(withText: "Save")
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.heightAnchor.constraint(equalToConstant: 50).isActive = true
        container.addSubview(saveButton)
        
        saveButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        saveButton.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        saveButton.addTarget(self, action: #selector(savePressed), for: .primaryActionTriggered)
        
        return container
    }
    
    @objc func savePressed() {
        if nameTextField.text == "" && numberTextField.text == "" {
            nameErrorLabel.isHidden = false
            nameErrorLabel.text = "Name text field can not be empty"
            numberErrorLabel.isHidden = false
            numberErrorLabel.text = "Number text field can not be empty"
        } else if nameTextField.text == "" {
            nameErrorLabel.isHidden = false
            nameErrorLabel.text = "Name text field can not be empty"
            numberErrorLabel.isHidden = true
        } else if numberTextField.text == "" {
            numberErrorLabel.isHidden = false
            numberErrorLabel.text = "Number text field can not be empty"
            nameErrorLabel.isHidden = true
        }else {
            nameErrorLabel.isHidden = true
            numberErrorLabel.isHidden = true
            
            name = nameTextField.text!
            numberTextField.text = numberTextField.text!
            number = numberTextField.text!
            newContactDelegate?.didSaveContact(name: name, number: number, gender: gender)
            self.navigationController?.popViewController(animated: true)
            
            
            
        }
    }
    
    func setupErrorLabel(errorLabel: UILabel) {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textColor = .systemRed
        errorLabel.font = UIFont.systemFont(ofSize: 14)
        errorLabel.isHidden = true
    }

    
    

}


extension NewContactVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender = genders[row]
    }
}

extension NewContactVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    

}

extension NewContactVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        numberTextField.text = numberTextField.text?.applyPatternOnNumbers(pattern: "+# (###) ###-##-##", replacementCharacter: "#")
        return true
    }
}



func makeTextField(placeholder: String) -> UITextField {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = placeholder
    textField.backgroundColor = .systemGray5
    textField.borderStyle = .roundedRect
    return textField
}

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 10
    
    return button
}




extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
