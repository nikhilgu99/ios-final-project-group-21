//
//  AddWorkoutViewController.swift
//  Final Project Group 21
//
//  Created by MAD2 on 11/29/24.
//

import Foundation
import UIKit
import FirebaseFirestore

class AddWorkoutViewController: UIViewController {
    
    
    let addWorkoutScreen = AddWorkoutView()
    var workout: Workout!
    var exercisesList = [Exercise]()
    let database = Firestore.firestore()
    
    override func loadView() {
        view = addWorkoutScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Workout"
        
        addWorkoutScreen.tableViewExercises.delegate = self
        addWorkoutScreen.tableViewExercises.dataSource = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        addWorkoutScreen.buttonAddExercise.addTarget(self, action: #selector(onButtonAddExerciseTapped), for: .touchUpInside)
    }
    
    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }
    
    @objc func onButtonAddExerciseTapped() {
        let addExerciseVC = AddExerciseViewController()
        navigationController?.pushViewController(addExerciseVC, animated: true)
    }
    
}

extension AddWorkoutViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercisesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewExercisesID, for: indexPath) as! ExercisesTableViewCell
        cell.labelName.text = exercisesList[indexPath.row].name
        cell.labelSetsAndReps.text = String(exercisesList[indexPath.row].reps) + " x " + String(exercisesList[indexPath.row].sets)
        cell.labelRest.text = String(exercisesList[indexPath.row].rest) + " seconds"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){ //getMessages(id: self.workoutsList[indexPath.row].id!)
        //todo launch the add exercise screen from here
    }
}
