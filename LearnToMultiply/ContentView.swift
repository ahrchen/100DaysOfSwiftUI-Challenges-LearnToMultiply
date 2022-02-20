//
//  ContentView.swift
//  LearnToMultiply
//
//  Created by Raymond Chen on 2/19/22.
//

import SwiftUI

struct ContentView: View {
    
    struct Question {
        let questionString: String
        let answer: Int
    }
    
    let images = [
        "bear",
        "buffalo",
        "chick",
        "chicken",
        "cow",
        "crocodile",
        "dog",
        "duck",
        "elephant",
        "frog",
        "giraffe",
        "goat",
        "gorilla",
        "hippo",
    ]
    
    @State private var questionBank = [[Int]]()
    @State private var currentQuestions = [Question]()
    
    @State private var maxMultiples = 2
    @State private var numQuestions = 5
    @State private var start = false
    @State private var gameOver = false
    @State private var incorrectAnswer = false
    
    @State private var questionsAnswered = 0
    @State private var correctAnswers = 0
    @State private var answer: Int?
    @State private var gameOverMessage = ""
    @State private var incorrectAnswerMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if start {
                    VStack {
                        Form {
                            Section {
                                Text("\(currentQuestions[questionsAnswered].questionString)")
                                TextField("Answer", value:$answer, format:.number)
                                    .keyboardType(.numberPad)
                                    .onSubmit {
                                        answerSelected()
                                    }
                            } header: {
                                Text("Question")
                            }
                        }
                        Button("Submit") {
                            answerSelected()
                        }
                    }
                    
                } else {
                    Form {
                        Section {
                            ForEach(2 ..< 13, id: \.self) { i in
                                HStack {
                                    Button {
                                        maxMultiples = i
                                    } label : {
                                        HStack {
                                            ForEach(0 ..< i, id: \.self) { _ in
                                                Image(images[i])
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .shadow(
                                                        color: maxMultiples == i ? .blue : .clear,
                                                        radius: 5
                                                    )
                                            }
                                        }
                                        .frame(maxHeight: 50)
                                    }
                                }
                            }
                        } header: {
                            Text("How many multiples?")
                        }
                        
                        Section {
                            Picker("Number of questions", selection: $numQuestions) {
                                ForEach(Array(stride(from: 5, through: 20, by: 5)), id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.segmented)
                        } header: {
                            Text("How many questions?")
                        }
                    }
                }
            }
            .navigationTitle("Learn Multiplications")
            .toolbar {
                Button("Start") {
                    startGame()
                }
                .disabled(start)
            }
            .alert(isPresented: $incorrectAnswer) {
                Alert(
                    title: Text(gameOver ? "Game Over" : "Incorrect Answer"),
                    message: Text(gameOver ? gameOverMessage + "\n" + incorrectAnswerMessage: incorrectAnswerMessage),
                    dismissButton: .default(Text(gameOver ? "Reset" : "Got it!" )) {
                        if gameOver {
                            reset()
                        }
                    }
                )
            }
            .alert("Game Over", isPresented: $gameOver) {
                Button("Reset", action: reset)
            } message: {
                Text(gameOverMessage)
            }
        }
        .onAppear(perform: loadQuestions)
        
        
    }
    
    func answerSelected() {
        if answer == currentQuestions[questionsAnswered].answer {
            correctAnswers += 1
        } else {
            incorrectAnswerMessage = "\(currentQuestions[questionsAnswered].questionString) is \(currentQuestions[questionsAnswered].answer)"
            incorrectAnswer.toggle()
        }
        questionsAnswered += 1
        answer = nil
        checkIsGameOver()
    }
    
    func checkIsGameOver() {
        if questionsAnswered == numQuestions {
            gameOverMessage = "You got \(correctAnswers) out of \(questionsAnswered)"
            gameOver.toggle()
        }
    }
    
    func startGame() {
        var numQuestionSelected = 0
        while numQuestionSelected <= numQuestions + 1 {
            let randomMultipleA = Int.random(in: 2..<maxMultiples + 1)
            let randomMultipleB = Int.random(in: 1..<13)
            let randomMultipleTotal = questionBank[randomMultipleA - 2][randomMultipleB - 1]
            currentQuestions.append(Question(
                questionString: "\(randomMultipleA) * \(randomMultipleB)",
                answer: randomMultipleTotal)
            )
            numQuestionSelected += 1
        }
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
    
    func reset() {
        currentQuestions = []
        questionsAnswered = 0
        correctAnswers = 0
        gameOver = false
        start.toggle()
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
