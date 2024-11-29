//
//  Workout.swift
//  Final Project Group 21
//
//  Created by MAD2 on 11/28/24.
//

import Foundation

struct Workout: Codable {
    
    var name: String
    var excercises: [Excercise]
    
    init(name: String, excercises: [Excercise]) {
        self.name = name
        self.excercises = excercises
    }
    
}
