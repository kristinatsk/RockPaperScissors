//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kristina Kostenko on 16.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var winningMoves = ["Paper", "Scissors", "Rock"]
    @State private var emojiMoves = ["👊", "🔖", "✂️"]
    @State private var shouldWin = Bool.random()
    
    @State private var correctMove = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionsCount = 0
    let totalQuestions = 10
    
    
    var body: some View {
        
        VStack {
            
            VStack(spacing: 15) {
                VStack {
                    if shouldWin {
                        Text("Tap move to win")
                    } else {
                        Text("Tap move to lose")
                    }
                    Text(moves[correctMove])
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0..<3) { number in
                    
                    Button (action: {
                        moveTapped(number)
                    }) {
                        Text(emojiMoves[number])
                            .font(.system(size: 150))
                    }
                }
                
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.black)
                    .font(.title.bold())
            }
        }
        .padding()
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game over", isPresented: $showingFinalScore) {
            Button("Reset", action: resetGame)
        } message: {
            Text("Your final score is \(score)")
        }
        
    }

    func moveTapped(_ number: Int) {
        if shouldWin || !shouldWin {
            
            if moves[number] == winningMoves[correctMove] || moves[number] != winningMoves[correctMove] {
                scoreTitle = "Correct"
                score += 1
                
            } else {
                scoreTitle = "Wrong!"
                score -= 1
            }
        }
            questionsCount += 1
        

            
        if questionsCount == totalQuestions {
            showingFinalScore = true
            showingScore = true
        } else {
            showingScore = true
        }
        
    }
    
    func askQuestion() {
        moves.shuffle()
        correctMove = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func resetGame() {
        scoreTitle = ""
        score = 0
        questionsCount = 0
        moves.shuffle()
        correctMove = Int.random(in: 0...2)
        //askQuestion()
    }
}

#Preview {
    ContentView()
}
