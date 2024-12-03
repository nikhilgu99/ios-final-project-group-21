//
//  RegisterViewController.swift
//  Final Project Group 21
//
//  Created by Derek Zhang on 12/2/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    // MARK: - Properties
    private lazy var registerView: RegisterScreenView = {
        let view = RegisterScreenView()
        return view
    }()
    private let database = Firestore.firestore() // Initialize Firestore

    // MARK: - Lifecycle
    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupTapGestureToDismissKeyboard() // Retain tap-to-dismiss behavior
    }

    // MARK: - Setup Actions
    private func setupActions() {
        registerView.registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        registerView.backButton.addTarget(self, action: #selector(handleBackToLogin), for: .touchUpInside)
    }

    private func setupTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true) // Dismiss the keyboard
    }

    // MARK: - Registration Logic
    @objc private func handleRegister() {
        // Validate input fields
        if let errorMessage = validateInput() {
            showAlert(message: errorMessage)
            return
        }

        let email = registerView.emailTextField.text ?? ""
        let password = registerView.passwordTextField.text ?? ""
        let username = registerView.usernameTextField.text ?? ""

        // Register user in Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                self.showAlert(message: "Registration failed: \(error.localizedDescription)")
                return
            }

            guard let user = authResult?.user else { return }

            // Update user profile
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges { error in
                if let error = error {
                    self.showAlert(message: "Failed to update profile: \(error.localizedDescription)")
                    return
                }

                // Store user details in Firestore
                self.storeUserDetails(uid: user.uid, username: username, email: email)
            }
        }
    }

    private func storeUserDetails(uid: String, username: String, email: String) {
        database.collection("users").document(uid).setData([
            "username": username,
            "email": email
        ]) { [weak self] error in
            guard let self = self else { return }

            if let error = error {
                self.showAlert(message: "Failed to save user details: \(error.localizedDescription)")
                return
            }

            // Registration successful - navigate to main screen
            self.showAlert(title: "Success", message: "Registration successful!") {
                let mainVC = ViewController() // Replace with your main screen's class
                self.navigationController?.setViewControllers([mainVC], animated: true)
            }
        }
    }

    // MARK: - Input Validation
    private func validateInput() -> String? {
        if registerView.usernameTextField.text?.isEmpty ?? true {
            return "Please enter a username."
        }
        if registerView.emailTextField.text?.isEmpty ?? true {
            return "Please enter an email."
        }
        if registerView.passwordTextField.text?.isEmpty ?? true {
            return "Please enter a password."
        }
        if registerView.confirmPasswordTextField.text != registerView.passwordTextField.text {
            return "Passwords do not match."
        }
        return nil
    }

    // MARK: - Navigation
    @objc private func handleBackToLogin() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Alert
    private func showAlert(title: String = "Error", message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true, completion: nil)
    }
}
