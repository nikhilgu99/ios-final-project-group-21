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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*if let user = Auth.auth().currentUser {
            self.database.collection("users").document(user.email!).collection("workouts")
                .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                    if let documents = querySnapshot?.documents{
                        self.workoutsList.removeAll()
                        for document in documents{
                            do{
                                //Add to list
                                let workoutData = try document.data(with: ServerTimestampBehavior(rawValue: 2)!)//.getDocument(as: Workout.self)
                                print(workoutData)
                                
                                let workout = Workout(name: workoutData["name"] as! String, exerciseInterval: workoutData["exerciseInterval"] as! Int, exercises: [])
                                
                                //todo add exercises
                                
                                self.workoutsList.append(workout)
                                print("added workout")
                                
                                
                            }catch{
                                print(error)
                            }
                        }
                        self.workoutsList.sort(by: {$0.name < $1.name})
                        self.mainScreen.tableViewWorkouts.reloadData()
                        print("got here")
                    }
                })
        }*/
        
        if let user = Auth.auth().currentUser {
            let allWorkouts = database.collection("users").document(user.uid).collection("workouts")
            Task{
                do {
                    let querySnapshot = try await allWorkouts.getDocuments()
                    //print(querySnapshot.documents)
                    
                    for document in querySnapshot.documents {
                        //print("\(document.documentID) => \(document.data())")
                        let workoutData = try document.data(with: ServerTimestampBehavior(rawValue: 2)!)
                        //print(workoutData)
                        
                        var workout = Workout(name: workoutData["name"] as! String, exerciseInterval: workoutData["exercise_interval"] as! Int, exercises: [])
                        
                        //get all exercises, for each one add it to workout
                        let qs2 = try await allWorkouts.document(document.documentID).collection("exercises").getDocuments()
                        
                        for exerciseDoc in qs2.documents {
                            let exerciseData = try exerciseDoc.data(with: ServerTimestampBehavior(rawValue: 2)!)
                            
                            let exercise = Exercise(name: exerciseData["name"] as! String,
                                                    sets: exerciseData["sets"] as! Int,
                                                    reps: exerciseData["reps"] as! Int,
                                                    rest: exerciseData["rest"] as! Int)
                            workout.exercises.append(exercise)
                        }
                        
                        self.workoutsList.append(workout)
                        //print("added")
                        
                    }
                    //print(self.workoutsList)
                    self.workoutsList.sort(by: {$0.name < $1.name})
                    self.mainScreen.tableViewWorkouts.reloadData()

                } catch {
                    print("Error getting documents: \(error)")
                }
            }
        }
        
    }
    
    @objc func onButtonProfileTapped() {
        //todo launch profile screen from here
        //print(String(self.workoutsList.count) + " workouts found locally")
        let profileVC = ProfileScreenViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc func onButtonAddWorkoutTapped() {
        //todo launch add workout screen from here
        let addWorkoutController = AddWorkoutViewController()
        addWorkoutController.workout = nil
        self.navigationController?.pushViewController(addWorkoutController, animated: true)
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

