//
//  ConfirmationVC.swift
//  Not A Shopping List
//
//  Created by Kenny on 12/21/19.
//  Copyright © 2019 Hazy Studios. All rights reserved.
//

import UIKit

class ConfirmationVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var emailLbl: UITextField!
    @IBAction func emailBtnTapped(_ sender: UIButton) {
        sendEmailList()
    }
    var name: String?
    var email: String?
    
    //MARK: Class Properties
    var desks: [Desk]?
    
    var furnitureDealer: FurnitureDealer? {
        didSet {
            updateViews()
        }
    }
    
    var infoText: String {
        guard let desks = desks else {return "Email this list of desks to me!"}
        return "Email this list of \(desks.count) desk(s) to me!"
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        nameLbl.delegate = self
        emailLbl.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.infoLbl.text = infoText
    }
    
    //MARK: Helper Methods
    func updateViews() {
        //TODO: Populate horizontal collectionview with picked desks
        self.desks = furnitureDealer!.pickedDesks //force unwrapped because this is only called when furnitureDealer is set
    }
    //print string of selected desks
    func prettyPrinted() -> String {
        guard let desks = desks else {return "No Desks Were Selected"}
        var prettyString = ""
        for (index, desk) in desks.enumerated() {
            if desks.count > 1 {
                if index != desks.count - 1 {
                    prettyString.append("\(desk.name), ")
                } else {
                    prettyString.append("and \(desk.name)")
                }
            } else {
                prettyString = desk.name
            }
        }
        return prettyString
    }
    
    func sendEmailList() {
        if let name = name, name != "",
           let email = email, email != "" {
            Alert.show(title: "Sending \(prettyPrinted())", message: "We're sending your list of desks to \(name) at \(email)!", vc: self)
            navigationController?.popViewController(animated: true)
        } else {
            Alert.show(title: "Oops!", message: "Please enter your name and email address!", vc: self)
        }
    }
}

extension ConfirmationVC: UICollectionViewDelegate {
    
}

extension ConfirmationVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        furnitureDealer?.pickedDesks.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DeskCell else {return UICollectionViewCell()}
        cell.desk = furnitureDealer?.pickedDesks[indexPath.item]
        return cell
    }
    
    
}

extension ConfirmationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            #warning("don't ever name a textfield lbl - lol")
        case nameLbl:
            nameLbl.resignFirstResponder()
            //performing these checks here for convenience (to switch text field if it needs to be filled in, or automatically submit the email request
            if name != nil, name != "", email != nil, email != "" {
                sendEmailList()
            } else {
                emailLbl.becomeFirstResponder()
            }
        default:
            sendEmailList()
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case nameLbl:
            name = nameLbl.text
        case emailLbl:
            email = emailLbl.text
        default:
            break
        }
    }
}
