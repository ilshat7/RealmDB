//
//  ViewController.swift
//  RealmDB
//
//  Created by Ильшат Мухамедьянов on 29.06.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.text = Persistence.shared.userName
        surnameTF.text = Persistence.shared.userSurname
    }
    
    @IBAction func saveButton(_ sender: Any) {
        Persistence.shared.userName = nameTF.text?.trimmingCharacters(in: .whitespaces)
        Persistence.shared.userSurname = surnameTF.text?.trimmingCharacters(in: .whitespaces)
        
    }
    


}

