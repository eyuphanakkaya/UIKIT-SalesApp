//
//  RegisterViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 2.09.2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    var alert = MyAlerts()
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func createUsers(name: String, mail: String, password: String) {
        Auth.auth().createUser(withEmail: mail, password: password) { result, error in
            guard error == nil else{
                if mail == "" ||  password == "" {
                    self.alert.loginError(title: "Hata", message: "Lütfen boş bırakmayınız.", viewControllers: self)
                    
                } else if password.count < 7 {
                    self.alert.loginError(title: "Hata", message: "Şifre en az 7 karakter olmalı", viewControllers: self)
                }
                return
            }
            let changesRequest = result?.user.createProfileChangeRequest()
            changesRequest?.displayName = name
            changesRequest?.commitChanges(completion: { error in
                if let error = error {
                    print(error)
                } else {
                    print("Kullanıcı başarıyla oluşturuldu")
                }
            })
        }
    }
    @IBAction func loginBackClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func registerClicked(_ sender: Any) {
        if let name = nameTextField.text ,
           let mail = mailTextField.text,
           let password = passwordTextField.text {
            if alert.isValidEmail(mail) {
                createUsers(name: name, mail: mail, password: password)

            } else {
                alert.loginError(title: "Hata", message: "Lütfen mail adresini geçerli giriniz.", viewControllers: self)
            }
        }
    }
    
}
