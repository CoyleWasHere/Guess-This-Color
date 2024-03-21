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
                    Spacer()
                }
                .padding()
                
                // How to Play
                HStack{
                    Spacer()
                    VStack{
                        Text("Total Score:")
                        Text("\(totalScore)")
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
                        
                        var a = 1
                        var b = 2
                        var c = 3
                        var d = 4
                        var e = 5
                        
                        var actualLetterValue = randomValue.split(separator: "")[0]
                        var actualNumberValue = randomValue.split(separator: "")[1]
                        var selectedLetterValue = color.split(separator: "")[0]
                        var selectedNumberValue = color.split(separator: "")[1]
                        
                        if color == randomValue {
                            print("Success")
                            totalScore += 3
                            
                            randomKey = dataService.getClues().randomElement()?.key ?? ""
                            randomValue = dataService.getClues()[randomKey] ?? ""
                        } else {
                            print("Too Far for guess")
                            
                            randomKey = dataService.getClues().randomElement()?.key ?? ""
                            randomValue = dataService.getClues()[randomKey] ?? ""
                        }
                        
                        // MARK: SOLUTION? for first part
//                        if actualLetterValue == selectedLetterValue && actualNumberValue == selectedNumberValue + 1 ||  actualNumberValue == selectedNumberValue - 1 {
//                            totalScore += 2
//                        } else if actualLetterValue == selectedLetterValue && actualNumberValue == selectedNumberValue + 2 ||  actualNumberValue == selectedNumberValue - 2{
//                            totalScore += 1
//                        }
                        
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
    
    func getRandomClue() -> String {
        let clues = dataService.getClues()
        let index: Int = Int(arc4random_uniform(UInt32(clues.count)))
        let randomClue = Array(clues.values)[index]
        return randomClue
    }
    
}

#Preview {
    PlayView()
}
