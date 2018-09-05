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
            self.usernameTextField.text = $0
        }
    }
    
    func setupLoginButton() {
        loginButton.layer.borderColor = UIColor.green.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.setTitleColor(UIColor.green, for: .normal)
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
        if textField == usernameTextField {
            userViewModel.updateUsername(username: newString)
        } else if textField == passwordTextField {
            userViewModel.updatePassword(password: newString)
        }
        
        return true
    }
}
