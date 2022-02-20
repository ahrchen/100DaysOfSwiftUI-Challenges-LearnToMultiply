//
//  ContentView.swift
//  LearnToMultiply
//
//  Created by Raymond Chen on 2/19/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var questionBank = [[Int]]()
    @State private var currentQuestions = [[Int]]()
    
    @State private var maxMultiples = 2
    @State private var numQuestions = 5
    @State private var start = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                if start {
                    Text("start")
                } else {
                    Form {
                        Stepper("Max \(maxMultiples)  Multiples", value: $maxMultiples, in: 2...12)
                        Stepper("\(numQuestions) Questions", value: $numQuestions, in: 5...20, step: 5)
                    }
                }
            }
            .navigationTitle("Learn Multiplications")
            .toolbar {
                Button("Start") {
                    startGame()
                }
            }
            
        }
        .onAppear(perform: loadQuestions)
        
    }
        
    func startGame() {
        start.toggle()
    }
    
    func loadQuestions() {
        for i in 2..<13 {
            var temp_array = [Int]()
            for j in 1 ..< 13 {
                temp_array.append(i * j)
            }
            questionBank.append(temp_array)
        }
        for questionSet in questionBank {
            print(questionSet)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
