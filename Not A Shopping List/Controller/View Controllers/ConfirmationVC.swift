//
//  ConfirmationVC.swift
//  Not A Shopping List
//
//  Created by Kenny on 12/21/19.
//  Copyright © 2019 Hazy Studios. All rights reserved.
//

import UIKit

class ConfirmationVC: UIViewController {
    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var emailLbl: UITextField!
    @IBAction func emailBtnTapped(_ sender: UIButton) {
        emailList()
    }
    var name: String?
    var email: String?
    
    //MARK: Class Properties
    var furnitureDealer: FurnitureDealer? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.delegate = self
        emailLbl.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: Helper Methods
    func updateViews() {
        
    }
    func emailList() {
        if let name = name, name != "",
           let email = email, email != "" {
            #warning("Alert Here to replace print()")
            print("Sending email list to \(name) at \(email)")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ConfirmationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            #warning("don't ever name a textfield lbl - lol")
        case nameLbl:
            nameLbl.resignFirstResponder()
            //performing these checks here for convenience (to switch text field if it needs to be filled in, or automatically submit the email request
            if name != nil, name != "", email != nil, email != "" {
                emailList()
            } else {
                emailLbl.becomeFirstResponder()
            }
        default:
            emailList()
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
