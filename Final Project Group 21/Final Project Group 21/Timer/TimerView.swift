//
//  TimerView.swift
//  Final Project Group 21
//
//  Created by Comus Hardman IV on 11/30/24.
//

import SwiftUI

struct TimerView: View {
    let workout: Workout

    @State private var timeRemaining: Int = 0
    @State private var isTimerRunning = false
    @State private var currentExerciseIndex = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Workout is... \(workout.name)")
                .font(.title)
                .fontWeight(.bold)

            if currentExerciseIndex < workout.exercises.count {
                let currentExercise = workout.exercises[currentExerciseIndex]
                Text("Exercise is... \(currentExercise.name)")
                    .font(.headline)
                Text("Sets: \(currentExercise.sets) | Reps: \(currentExercise.reps)")
                Text("Catching your breath time... \(currentExercise.rest) seconds")

                Text("Time left... \(timeRemaining) seconds")
                    .font(.largeTitle)
                    .foregroundColor(timeRemaining > 0 ? .blue : .red)
                    .padding()

                Button(action: {
                    if isTimerRunning {
                        resetTimer()
                    } else {
                        startTimer(for: currentExercise.rest)
                    }
                }) {
                    Text(isTimerRunning ? "Stop timer" : "Start the timer")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isTimerRunning ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            } else {
                Text("Workout done woo!")
                    .font(.headline)
                    .foregroundColor(.green)
            }

            Spacer()

            if currentExerciseIndex < workout.exercises.count {
                Button("Next exercise") {
                    moveToNextExercise()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
        .padding()
        .onAppear {
            if !workout.exercises.isEmpty {
                timeRemaining = workout.exercises[currentExerciseIndex].rest
            }
        }
    }

    private func startTimer(for seconds: Int) {
        timeRemaining = seconds
        isTimerRunning = true

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isTimerRunning = false
                timer.invalidate()
            }
        }
    }

    private func resetTimer() {
        timeRemaining = workout.exercises[currentExerciseIndex].rest
        isTimerRunning = false
    }

    private func moveToNextExercise() {
        if currentExerciseIndex < workout.exercises.count - 1 {
            currentExerciseIndex += 1
            resetTimer()
        }
    }
}
