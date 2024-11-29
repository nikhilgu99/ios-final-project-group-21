//
//  Excercise.swift
//  Final Project Group 21
//
//  Created by MAD2 on 11/28/24.
//

import Foundation


struct Excercise: Codable {
    
    var name: String
    var sets: Int
    var reps: Int
    
    init(name: String, sets: Int, reps: Int) {
        self.name = name
        self.sets = sets
        self.reps = reps
    }
    
}
