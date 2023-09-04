//
//  LoginViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 2.09.2023.
//

import UIKit
import Firebase
import GoogleSignIn


class LoginViewController: UIViewController {
    var alert = MyAlerts()
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func loginClicked(_ sender: Any) {
        if let mail = mailTextField.text ,
           let password = passwordTextField.text {
            if alert.isValidEmail(mail) {
                login(mail: mail, password: password)

            } else {
                alert.loginError(title: "Hata", message: "Lütfen geçerli bir mail adresi girniz.", viewControllers: self)
            }
        }
    }
    func login(mail: String, password: String) {
        Auth.auth().signIn(withEmail: mail, password: password) { result, error in
            guard error == nil else{
                if mail == "" ||  password == "" {
                    self.alert.loginError(title: "Hata", message: "Lütfen boş bırakmayınız.", viewControllers: self)
                    
                }  else {
                    self.alert.loginError(title: "Hata", message: "Lütfen geçerli değerler giriniz veya kayıtlı değilseniz kayolunuz.", viewControllers: self)
                }
                return
            }
            self.performSegue(withIdentifier: "toMainVC", sender: nil)
            
            
            
        }
    }
    @IBAction func googleSignInClicked(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            if let error = error {
                // Hata işleme kodunu burada ekleyebilirsiniz
                print("Google girişi başarısız: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("Kullanıcı bilgisi yok")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    self.alert.loginError(title: "Hata", message: "Lütfen geçerli değer giriniz",viewControllers: LoginViewController())
                    return
                }
                self.performSegue(withIdentifier: "toMainVC", sender: nil)
            }
            
        }
    }
    
}


