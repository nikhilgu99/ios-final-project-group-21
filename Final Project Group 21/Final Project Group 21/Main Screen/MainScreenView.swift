//
//  MainScreenView.swift
//  Final Project Group 21
//
//  Created by MAD2 on 11/27/24.
//

import Foundation
import UIKit

class MainScreenView: UIView {

    //var labelName: UILabel!
    var buttonAddWorkout: UIButton!
    var buttonProfile: UIButton!
    var tableViewWorkouts: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        //setupLabelName()
        setupProfileButton()
        setupAddWorkoutButton()
        setupTableViewWorkouts()
        initConstraints()
    }
    
    /*func setupLabelName(){
        labelName = UILabel()
        labelName.text = "LabelName"
        labelName.font = .boldSystemFont(ofSize: 14)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }*/
    
    func setupTableViewWorkouts(){
        tableViewWorkouts = UITableView()
        tableViewWorkouts.register(WorkoutsTableViewCell.self, forCellReuseIdentifier: Configs.tableViewWorkoutsID)
        tableViewWorkouts.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewWorkouts)
    }
    
    func setupAddWorkoutButton(){
        buttonAddWorkout = UIButton(type: .system)
        buttonAddWorkout.setTitle("Add Workout", for: .normal)
        //buttonAddWorkout.setImage(UIImage(systemName: "person.crop.circle.fill.badge.plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttonAddWorkout.contentHorizontalAlignment = .fill
        buttonAddWorkout.contentVerticalAlignment = .fill
        buttonAddWorkout.imageView?.contentMode = .scaleAspectFit
        buttonAddWorkout.layer.cornerRadius = 16
        buttonAddWorkout.imageView?.layer.shadowOffset = .zero
        buttonAddWorkout.imageView?.layer.shadowRadius = 0.8
        buttonAddWorkout.imageView?.layer.shadowOpacity = 0.7
        buttonAddWorkout.imageView?.clipsToBounds = true
        buttonAddWorkout.translatesAutoresizingMaskIntoConstraints = false
        buttonAddWorkout.titleLabel?.textAlignment = .center
        buttonAddWorkout.backgroundColor = Configs.buttonBackgroundColor
        self.addSubview(buttonAddWorkout)
    }
    
    func setupProfileButton(){
        buttonProfile = UIButton(type: .system)
        buttonProfile.setTitle("Profile", for: .normal)
        //buttonProfile.setImage(UIImage(systemName: "person.crop.circle.fill.badge.plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttonProfile.contentHorizontalAlignment = .fill
        buttonProfile.contentVerticalAlignment = .fill
        buttonProfile.imageView?.contentMode = .scaleAspectFit
        buttonProfile.layer.cornerRadius = 16
        buttonProfile.imageView?.layer.shadowOffset = .zero
        buttonProfile.imageView?.layer.shadowRadius = 0.8
        buttonProfile.imageView?.layer.shadowOpacity = 0.7
        buttonProfile.imageView?.clipsToBounds = true
        buttonProfile.translatesAutoresizingMaskIntoConstraints = false
        buttonProfile.titleLabel?.textAlignment = .center
        buttonProfile.backgroundColor = Configs.buttonBackgroundColor
        self.addSubview(buttonProfile)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            /*labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),*/
            
            buttonAddWorkout.widthAnchor.constraint(equalToConstant: 100),
            buttonAddWorkout.heightAnchor.constraint(equalToConstant: 48),
            buttonAddWorkout.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonAddWorkout.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: -16),
            
            buttonProfile.widthAnchor.constraint(equalToConstant: 100),
            buttonProfile.heightAnchor.constraint(equalToConstant: 48),
            buttonProfile.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonProfile.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 16),
            
            tableViewWorkouts.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewWorkouts.bottomAnchor.constraint(equalTo: self.buttonProfile.topAnchor, constant: -8),
            tableViewWorkouts.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewWorkouts.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
