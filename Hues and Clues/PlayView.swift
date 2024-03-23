//
//  PlayView.swift
//  Hues and Clues
//
//  Created by Daniel Coyle on 3/20/24.
//

import SwiftUI
import AVFoundation

struct PlayView: View {
    @Environment(\.dismiss) private var dismiss
    @State var audioPlayer:AVAudioPlayer?
    
    var dataService:DataService = DataService()
    private var columns: [GridItem] = [
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0),
        GridItem(.fixed(55), spacing: 0)]
    
    @State var backAlert = false
    @State var restartAlert = false
    @State var showSheet = false
    @State var scoring = true
    
    @State var totalScore = 0
    @State var numberComparison = 0
    @State var actualNumber = 0
    @State var selectedNumber = 0
    @State var guessNumber = 0
    @State var clueNumber = "First Clue: "
    @State var totalScoreWord = "Total Score:"
    
    @State var correctAnswer = ""
    @State var randomKey = ""
    @State var randomValue = ""
    @State var selectedColor = ""
    @State var answerColor = ""
    
    
    var body: some View {
        
        VStack{
            // Navigation Bar
            ZStack{
                // Title
                Text("\(clueNumber)\(randomKey)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.black)
                    .padding(.top)
                
                
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
                        Text("\(totalScoreWord)")
                        if totalScoreWord != "" {
                            Text("\(totalScore)")
                        }
                    }
                    Spacer()
                }
                .padding(.top)
                
                // How to Play & Restart
                HStack{
                    Spacer()
                    VStack{
                        Button {
                            restartAlert = true
                        } label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 80, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 110))
                                    .foregroundStyle(.gray)
                                
                                Text("Restart")
                                    .foregroundStyle(.white)
                                    .fontWeight(.semibold)
                            }
                        }
                        
                        .alert("Are you sure you want to restart?", isPresented: $restartAlert) {
                            Button {
                                withAnimation {
                                    selectedColor = ""
                                    answerColor = ""
                                    scoring = true
                                    totalScore = 0
                                    guessNumber = 0
                                    clueNumber = "First Clue: "
                                    totalScoreWord = "Total Score:"
                                    getRandomClue()
                                    restartSound()
                                    audioPlayer?.play()
                                }
                            } label: {
                                Text("Restart")
                            }
                            Button {
                            } label: {
                                Text("Continue Playing")
                            }
                        }
                    }
                    Button{
                        // Display InformationView Modally
                        showSheet = true
                    }label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                }
                .padding(.top)
                
            }
            Spacer()
            
            
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 0,
                      content: {
                
                ForEach(dataService.colorName(), id: \.self){ color in
                    Button {
                        guessNumber += 1
                        
                        selectedColor = color
                        answerColor = randomValue
                        
                        selectionSound()
                        audioPlayer?.play()
                        
                        let actualLetter = randomValue.split(separator: "")[0]
                        let selectedLetter = color.split(separator: "")[0]
                        
                        if let actualNumber = Int(randomValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                            self.actualNumber = Int(actualNumber)
                        }
                        if let selectedNumber = Int(color.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                            self.selectedNumber = Int(selectedNumber)
                        }
                        
                        let actualLetterValue = setNumberComparison(letter: String(actualLetter))
                        let selectedLetterValue = setNumberComparison(letter: String(selectedLetter))
                        
                        if scoring {
                            selectedAnswerCheck(color: color, actualLetterValue: actualLetterValue, actualNumber: actualNumber, selectedLetterValue: selectedLetterValue, selectedNumber: selectedNumber)
                        }
                        
                        setClueNumber()
                        
                        // print("Actual Row: \(actualLetterValue)")
                        // print("Guessed Row: \(selectedLetterValue)")
                        // print("Actual Column: \(actualNumber)")
                        // print("Guessed Column: \(selectedNumber)")
                        // print(selectedColor)
                        // print(answerColor)
                        
                    } label: {
                        
                        ZStack{
                            Rectangle()
                                .foregroundStyle(Color(color))
                                .frame(width: 55, height: 55)
                                .border(Color.black, width: 2.5)
                            HStack{
                                if selectedColor == color {
                                    Image(systemName: "hand.raised.fingers.spread")
                                        .foregroundStyle(.white)
                                }
                                if answerColor == color {
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(.white)
                                }
                            }
                        }
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
    
    func setClueNumber() {
        
        if totalScore == 15 {
            clueNumber = "Perfect Score: 15"
        }
        
        if guessNumber == 1 {
            clueNumber = "Second Clue: "
        }
        else if guessNumber == 2 {
            clueNumber = "Third Clue: "
        }
        else if guessNumber == 3 {
            clueNumber = "Fourth Clue: "
        }
        else if guessNumber == 4 {
            clueNumber = "Final Clue: "
        } else {
            scoring = false
            totalScoreWord = ""
            randomKey = ""
            clueNumber = "Final Score: \(totalScore)"
        }
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
    
    func selectedAnswerCheck(color: String, actualLetterValue: Int, actualNumber: Int, selectedLetterValue: Int, selectedNumber: Int) {
        // Correct Answer
        if color == randomValue {
            print("Success")
            totalScore += 3
            getRandomClue()
            
        }
        // If C4 Checks B3, B4, B5 and D3, D4, D5
        else if ((actualLetterValue == selectedLetterValue + 1) || (actualLetterValue == selectedLetterValue - 1)) && (actualNumber == selectedNumber || actualNumber == (selectedNumber + 1) || actualNumber == (selectedNumber - 1)) {
            
            print("2nd THIS WAS SCORED")
            totalScore += 2
            getRandomClue()
            
        }
        // If C4 Checks C3 and C5
        else if (actualLetterValue == selectedLetterValue) && (actualNumber == (selectedNumber + 1) || actualNumber == (selectedNumber - 1)){
            
            print(actualLetterValue)
            print(selectedLetterValue)
            print("3rd THIS WAS SCORED")
            totalScore += 2
            getRandomClue()
            
        }
        // If C4 Checks C2 and C6
        else if actualLetterValue == selectedLetterValue && (actualNumber == (selectedNumber + 2) || actualNumber == (selectedNumber - 2)){
            print("Added in late")
            totalScore += 1
            getRandomClue()
            
        } // If C4 Checks b2,b6 & d2,d6
        else if ((actualLetterValue == selectedLetterValue + 1) || (actualLetterValue == selectedLetterValue - 1))  && (actualNumber == (selectedNumber + 2) || actualNumber == (selectedNumber - 2)) {
            
            print("4th THIS WAS SCORED")
            totalScore += 1
            getRandomClue()
            
        }
        // If C4 Checks a2,a3,a4,a5,a6 & e2,e3,e4,e5,e6
        else if ((actualLetterValue == selectedLetterValue + 2) || (actualLetterValue == selectedLetterValue - 2))  && (actualNumber == (selectedNumber + 2) || actualNumber == (selectedNumber + 1) || actualNumber == selectedNumber || actualNumber == (selectedNumber - 1) || actualNumber == (selectedNumber - 2)) {
            print("5th THIS WAS SCORED")
            totalScore += 1
            getRandomClue()
            
        }
        // Incorrect Guess
        else {
            print("Too Far for guess")
            getRandomClue()
        }
    }
    
    func selectionSound() {
        // Load the audio file
        if let soundURL = Bundle.main.url(forResource: "correct", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.numberOfLoops = 0
            } catch {
                print("Error loading sound file: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found")
        }
    }
    func restartSound() {
        // Load the audio file
        if let soundURL = Bundle.main.url(forResource: "restart", withExtension: "aiff") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.numberOfLoops = 0
            } catch {
                print("Error loading sound file: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found")
        }
    }
    
}

#Preview {
    PlayView()
}
