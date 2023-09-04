//
//  Alerts.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 4.09.2023.
//

import Foundation
import UIKit

class MyAlerts {
    func loginError(title: String, message: String,viewControllers: UIViewController?) {
        guard let viewController = viewControllers else {
            return
        }
        
        let alerts = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actions = UIAlertAction(title: "Tamam", style: .cancel)
        alerts.addAction(actions)
        viewController.present(alerts, animated: true)
    }
    func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
