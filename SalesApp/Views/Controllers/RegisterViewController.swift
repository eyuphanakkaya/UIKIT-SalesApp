//
//  RegisterViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 2.09.2023.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBackClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func registerClicked(_ sender: Any) {
    }
    @IBAction func googleSignInClicked(_ sender: Any) {
    }
}
