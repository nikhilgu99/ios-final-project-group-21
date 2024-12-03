//
//  LoginScreenViewController.swift
//  Final Project Group 21
//
//  Created by Derek Zhang on 12/2/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginScreenViewController: UIViewController {

    // MARK: - Properties
    private lazy var loginView: LoginScreenView = {
        let view = LoginScreenView()
        return view
    }()

    // MARK: - Lifecycle
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupTapGestureToDismissKeyboard() // Only retain tap-to-dismiss
    }

    // MARK: - Setup Actions
    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }

    private func setupTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true) // Dismiss the keyboard
    }

    // MARK: - Actions
    @objc private func handleLogin() {
        if let errorMessage = validateInput() {
            showAlert(message: errorMessage)
            return
        }

        let username = loginView.usernameTextField.text ?? ""
        let password = loginView.passwordTextField.text ?? ""

        // Query Firestore for the email associated with the username
        let db = Firestore.firestore()
        db.collection("users").whereField("username", isEqualTo: username).limit(to: 1).getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }

            if let error = error {
                self.showAlert(message: "Login failed: \(error.localizedDescription)")
                return
            }

            guard let documents = querySnapshot?.documents, !documents.isEmpty,
                  let email = documents.first?.data()["email"] as? String else {
                self.showAlert(message: "Username not found.")
                return
            }

            // Use the retrieved email to sign in the user
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let error = error {
                    self.showAlert(message: "Login failed: \(error.localizedDescription)")
                    return
                }

                print("User logged in successfully: \(authResult?.user.uid ?? "Unknown UID")")
                self.navigateToMainScreen()
            }
        }
    }

    @objc private func handleSignUp() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }

    // MARK: - Navigation
    private func navigateToMainScreen() {
        let mainVC = ViewController() // Replace with your main screen's class
        navigationController?.setViewControllers([mainVC], animated: true)
    }

    // MARK: - Input Validation
    private func validateInput() -> String? {
        if loginView.usernameTextField.text?.isEmpty ?? true {
            return "Please enter your username."
        }
        if loginView.passwordTextField.text?.isEmpty ?? true {
            return "Please enter your password."
        }
        return nil
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
