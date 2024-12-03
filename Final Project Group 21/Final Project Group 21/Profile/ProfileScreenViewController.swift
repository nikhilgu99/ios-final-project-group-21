//
//  ProfileScreenViewController.swift
//  Final Project Group 21
//
//  Created by Derek Zhang on 12/2/24.
//

import UIKit
import FirebaseAuth

class ProfileScreenViewController: UIViewController {

    private let profileView = ProfileScreenView()

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        profileView.buttonSignOut.addTarget(self, action: #selector(onSignOutTapped), for: .touchUpInside)
    }

    @objc func onSignOutTapped() {
        do {
            try Auth.auth().signOut()
            print("User signed out successfully")

            // Navigate back to the login screen
            let loginVC = LoginScreenViewController()
            let navigationController = UINavigationController(rootViewController: loginVC)
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
