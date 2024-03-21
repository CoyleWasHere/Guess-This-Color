//
//  PlayView.swift
//  Hues and Clues
//
//  Created by Daniel Coyle on 3/20/24.
//

import SwiftUI

struct PlayView: View {
    @Environment(\.dismiss) private var dismiss
    
    var dataService:DataService = DataService()
    private var columns: [GridItem] = [
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0),
        GridItem(.fixed(58), spacing: 0)]
    
    @State var backAlert = false
    @State var showSheet = false
    
    @State var totalScore = 0
    @State var numberComparison = 0
    
    @State var randomKey = ""
    @State var randomValue = ""
    
    
    var body: some View {
        
        
        
        VStack{
            ZStack{
                Text("First Clue: \(randomKey)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.black)
                
                // Go Back
                HStack{
                    Button{
                        // Go Back One Page
                        backAlert = true
                    }label: {
                        Image(systemName: "arrowshape.backward.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                    .alert("Are you sure you want to go back?", isPresented: $backAlert) {
                        Button{
                            dismiss()
                        }label: {
                            Text("Go Back")
                        }
                        Button{
                            
                        }label: {
                            Text("Continue Playing")
                        }
                    }
                    
                    VStack{
                        Text("Total Score:")
                        Text("\(totalScore)")
                    }
                    Spacer()
                }
                .padding()
                
                // How to Play
                HStack{
                    Spacer()
                    Text("RESTART")
                    Button{
                        // Display InformationView Modally
                        showSheet = true
                    }label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                }
                .padding()
                
            }
            Spacer()
            
            
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 0,
                      content: {
                
                ForEach(dataService.colorName(), id: \.self){ color in
                    Button {
                        
                        //TODO: Based on the clue, Award points for correct answers
                        
                        let actualLetter = randomValue.split(separator: "")[0]
                        let actualNumber = randomValue.split(separator: "")[1]
                        let selectedLetter = color.split(separator: "")[0]
                        let selectedNumber = color.split(separator: "")[1]
                        
                        let actualLetterValue = setNumberComparison(letter: String(actualLetter))
                        let selectedLetterValue = setNumberComparison(letter: String(selectedLetter))

                        // Correct Answer
                        if color == randomValue {
                            print("Success")
                            totalScore += 3
                            getRandomClue()
                            
                        } // If C4 Checks B3, B4, B5 and D3, D4, D5
                        else if ((actualLetterValue == selectedLetterValue + 1) || (actualLetterValue == selectedLetterValue - 1)) && (actualNumber == selectedNumber || Int(actualNumber) == (Int(selectedNumber)! + 1) || Int(actualNumber) == (Int(selectedNumber)! - 1)) {
                            
                            print("2nd THIS WAS SCORED")
                            totalScore += 2
                            getRandomClue()
                            
                        } // If C4 Checks C3 and C5
                        else if (actualLetterValue == selectedLetterValue) && (Int(actualNumber) == (Int(selectedNumber)! + 1) || Int(actualNumber) == (Int(selectedNumber)! - 1)){
                            
                            print(actualLetterValue)
                            print(selectedLetterValue)
                            print("3rd THIS WAS SCORED")
                            totalScore += 2
                            getRandomClue()
                            
                        } // If C4 Checks C2 and C6
                        else if actualLetterValue == selectedLetterValue && (Int(actualNumber) == (Int(selectedNumber)! + 2) || Int(actualNumber) == (Int(selectedNumber)! - 2)){
                            print("Added in late")
                            totalScore += 1
                            getRandomClue()
                            
                        } // If C4 Checks b2,b6 & d2,d6
                        else if ((actualLetterValue == selectedLetterValue + 1) || (actualLetterValue == selectedLetterValue - 1))  && (Int(actualNumber) == (Int(selectedNumber)! + 2) || Int(actualNumber) == (Int(selectedNumber)! - 2)) {
                            
                            print("4th THIS WAS SCORED")
                            totalScore += 1
                            getRandomClue()
                            
                        } // If C4 Checks a2,a3,a4,a5,a6 & e2,e3,e4,e5,e6
                        else if ((actualLetterValue == selectedLetterValue + 2) || (actualLetterValue == selectedLetterValue - 2))  && (Int(actualNumber) == (Int(selectedNumber)! + 2) || Int(actualNumber) == (Int(selectedNumber)! + 1) || actualNumber == selectedNumber || Int(actualNumber) == (Int(selectedNumber)! - 1) || Int(actualNumber) == (Int(selectedNumber)! - 2)) {
                            print("5th THIS WAS SCORED")
                            totalScore += 1
                            getRandomClue()
                            
                        } // Incorrect Guess
                        else {
                            print("Too Far for guess")
                            getRandomClue()
                        }
                        
                    } label: {
                        Rectangle()
                            .foregroundStyle(Color(color))
                            .frame(width: 58, height: 58)
                            .border(Color.black, width: 2.5)
                    }
                }
            })
        }
        .toolbar(.hidden, for: .navigationBar)
        .background(Image("background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea())
        .sheet(isPresented: $showSheet, content: {
            InformationView()
        })
        .onAppear(perform: {
            randomKey = dataService.getClues().randomElement()?.key ?? ""
            randomValue = dataService.getClues()[randomKey] ?? ""
        })
        
    }
    
    func getRandomClue() {
        randomKey = dataService.getClues().randomElement()?.key ?? ""
        randomValue = dataService.getClues()[randomKey] ?? ""
    }
    
    func setNumberComparison(letter: String) -> Int {
        if letter == "a" {
            numberComparison = 1
        }
        if letter == "b" {
            numberComparison = 2
        }
        if letter == "c" {
            numberComparison = 3
        }
        if letter == "d" {
            numberComparison = 4
        }
        if letter == "e" {
            numberComparison = 5
        }
        return numberComparison
    }
    
    // MARK: TEST . . . IGNORE
    func selectedAnswerCheck(actualLetter: String, actualNumber: String, selectedLetter: String, selectedNumber: String) {
        
        // If C4 Checks b3b4b5 and d3d4d5
//        if (actualLetter == selectedLetter + 1) || (actualLetter == selectedLetter - 1) && actualNumber == selectedNumber || Int(actualNumber) == (Int(selectedNumber)! + 1) || Int(actualNumber) == (Int(selectedNumber)! - 1) {
//            totalScore += 2
//        }
        
            // If C4 Checks C3 and C5
//        if actualLetter == selectedLetter && Int(actualNumber) == (Int(selectedNumber)! + 1) || Int(actualNumber) == (Int(selectedNumber)! - 1){
//            totalScore += 2
//            
//            // If C4 Checks C2 and C6
//        } else if actualLetter == selectedLetter && Int(actualNumber) == (Int(selectedNumber)! + 2) || Int(actualNumber) == (Int(selectedNumber)! - 2){
//            totalScore += 1
//        }
        
        // If C4 Checks b2,b6 & d2,d6
//         else if (actualLetter == selectedLetter + 1) || (actualLetter == selectedLetter - 1)  && Int(actualNumber) == (Int(selectedNumber)! + 2) || Int(actualNumber) == (Int(selectedNumber)! - 2) {
//
            // If C4 Checks a2,a3,a4,a5,a6 & e2,e3,e4,e5,e6
//        } else if (actualLetter == selectedLetter + 2) || (actualLetter == selectedLetter - 2)  && Int(actualNumber) == (Int(selectedNumber)! + 2) || Int(actualNumber) == (Int(selectedNumber)! + 1) || actualNumber == selectedNumber || Int(actualNumber) == (Int(selectedNumber)! - 1) || Int(actualNumber) == (Int(selectedNumber)! + 2) {
//
//        }
        
    }
    
    
}

#Preview {
    PlayView()
}
