//
//  LoginViewController.swift
//  MVVMDemoApp
//
//  Created by Amol Bombe on 25/08/18.
//  Copyright © 2018 Amol. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        setupLoginButton()
        
        userViewModel.username.bind {
            print("Username Changed: \($0)")
        }
    }
    
    func setupLoginButton() {
        let greenColor = UIColor(red: 22/255, green: 166/255, blue: 140/255, alpha: 1)
        loginButton.layer.borderColor = greenColor.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.setTitleColor(greenColor, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        dismissKeyboard()
        switch userViewModel.validate() {
        case .Valid:
            userViewModel.login(completion: { errorString in
                if let error = errorString {
                    print(error)
                } else {
                    print("login success")
                    self.performSegue(withIdentifier: "showHomeScreen", sender: self)
                }
            })
        case .Invalid(let error):
                print(error)
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            textField.text = userViewModel.username.value
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            textField.text = userViewModel.username.value
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        print(newString)
        if textField == usernameTextField {
            userViewModel.updateUsername(username: newString)
        } else if textField == passwordTextField {
            userViewModel.updatePassword(password: newString)
        }
        
        return true
    }
}
