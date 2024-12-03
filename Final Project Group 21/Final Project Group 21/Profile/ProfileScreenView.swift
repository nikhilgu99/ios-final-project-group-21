//
//  ProfileScreenView.swift
//  Final Project Group 21
//
//  Created by Derek Zhang on 12/2/24.
//

import UIKit

class ProfileScreenView: UIView {

    var buttonSignOut: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupSignOutButton()
    }

    func setupSignOutButton() {
        buttonSignOut = UIButton(type: .system)
        buttonSignOut.setTitle("Sign Out", for: .normal)
        buttonSignOut.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        buttonSignOut.setTitleColor(.systemRed, for: .normal)
        buttonSignOut.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignOut)

        // Constraints for the Sign Out button
        NSLayoutConstraint.activate([
            buttonSignOut.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonSignOut.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
