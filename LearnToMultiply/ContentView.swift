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
        if start {
            Text("start")
        } else {
            Text("selection")
        }
        
            
        }
        .onAppear(perform: loadQuestions)
        .navigationTitle("Learn Multiplications")
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
