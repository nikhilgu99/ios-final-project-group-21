//
//  ViewController.swift
//  Final Project Group 21
//
//  Created by Nikhil Gupta on 11/11/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {

    let mainScreen = MainScreenView()
    var workoutsList = [Workout]()
    let database = Firestore.firestore()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "My Workouts"
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: Put the floating button above all the views...
        //view.bringSubviewToFront(mainScreen.floatingButtonAddContact)
        
        mainScreen.tableViewWorkouts.delegate = self
        mainScreen.tableViewWorkouts.dataSource = self
        
        mainScreen.buttonProfile.addTarget(self, action: #selector(onButtonProfileTapped), for: .touchUpInside)
        mainScreen.buttonAddWorkout.addTarget(self, action: #selector(onButtonAddWorkoutTapped), for: .touchUpInside)
    }
    
    @objc func onButtonProfileTapped() {
        //todo launch profile screen from here
    }
    
    @objc func onButtonAddWorkoutTapped() {
        //todo launch add workout screen from here
    }
    
    


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewWorkoutsID, for: indexPath) as! WorkoutsTableViewCell
        cell.labelName.text = workoutsList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){ //getMessages(id: self.workoutsList[indexPath.row].id!)
        //todo launch the do a workout screen from here
    }
}

