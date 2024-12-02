//
//  RegisterViewController.swift
//  Final Project Group 21
//
//  Created by Derek Zhang on 12/2/24.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Properties
    private let registerView = RegisterScreenView()

    // MARK: - Lifecycle
    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }

    // MARK: - Setup Actions
    private func setupActions() {
        registerView.registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        registerView.backButton.addTarget(self, action: #selector(handleBackToLogin), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func handleRegister() {
        // Get text field values
        let username = registerView.usernameTextField.text ?? ""
        let email = registerView.emailTextField.text ?? ""
        let password = registerView.passwordTextField.text ?? ""
        let confirmPassword = registerView.confirmPasswordTextField.text ?? ""

        // Create User instance
        let user = User(username: username, email: email, password: password)

        // Validate input
        if !user.isValidUsername() {
            showAlert(message: "Please enter a valid username.")
            return
        }

        if !user.isValidEmail() {
            showAlert(message: "Please enter a valid email address.")
            return
        }

        if !user.isValidPassword() {
            showAlert(message: "Password must be at least 6 characters long.")
            return
        }

        if !user.isMatchingPassword(confirmPassword) {
            showAlert(message: "Passwords do not match.")
            return
        }

        // Proceed with registration (e.g., Firebase)
        print("User registration successful: \(user)")
        // You can add Firebase integration here
    }

    @objc private func handleBackToLogin() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Helper Methods
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
