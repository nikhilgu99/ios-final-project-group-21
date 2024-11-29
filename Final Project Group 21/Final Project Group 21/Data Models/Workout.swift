//
//  Workout.swift
//  Final Project Group 21
//
//  Created by MAD2 on 11/28/24.
//

import Foundation

struct Workout: Codable {
    
    var name: String
    var exerciseInterval: Int
    var exercises: [Exercise]
    
    init(name: String, exerciseInterval: Int, exercises: [Exercise]) {
        self.name = name
        self.exerciseInterval = exerciseInterval
        self.exercises = exercises
    }
    
}
