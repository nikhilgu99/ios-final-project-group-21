//
//  LoginScreenViewController.swift
//  Final Project Group 21
//
//  Created by Derek Zhang on 12/2/24.
//

import UIKit

class LoginScreenViewController: UIViewController {

    // MARK: - Properties
    private let loginView = LoginScreenView()

    // MARK: - Lifecycle
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }

    // MARK: - Setup Actions
    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func handleLogin() {
        // Get text field values
        let username = loginView.usernameTextField.text ?? ""
        let password = loginView.passwordTextField.text ?? ""

        // Placeholder: Print username and password
        print("Login with Username: \(username), Password: \(password)")

        // Simple logic for testing (replace with real validation)
        if username == "tester1" && password == "1234567" {
            // Navigate to the main screen
            let mainScreenVC = ViewController()
            navigationController?.pushViewController(mainScreenVC, animated: true)
        } else {
            // Show error message
            showAlert(message: "Invalid username or password.")
        }
    }

    @objc private func handleSignUp() {
        // Navigate to the Register screen
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }

    // MARK: - Helper Methods
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
