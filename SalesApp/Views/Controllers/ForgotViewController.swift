//
//  ForgotViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 2.09.2023.
//

import UIKit
import Firebase

class ForgotViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func requestPasswordClicked(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: mailTextField.text!)
        
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}
