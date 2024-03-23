//
//  InformationView.swift
//  Hues and Clues
//
//  Created by Daniel Coyle on 3/20/24.
//

import SwiftUI

struct InformationView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ScrollView{
            VStack{
                ZStack{
                    Text("How To Play")
                        .font(.title)
                        .underline()
                    HStack{
                        Spacer()
                        Button{
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundStyle(.black)
                        }
                    }
                }
                // Game Directions
                VStack(alignment: .leading){
                    Text("- Each Game consists of Five clues")
                    Text("- The clues will be shown at the top of the screen")
                    Text("- You then guess what color you think the clue is.")
                    Text("- If you guess the correct color, you get 3 points")
                    Text("- If you are one square away, you get 2 points")
                    Text("- If you are two squares away, you get 1 point ")
                    Text("- If you are three or more squares away, you get no points.")
                    Text("- The correct answer will be marked with a") + Text(Image(systemName: "star.fill")) +  Text("after you take a guess")
                    Text("- The color you guessed will be marked with a") + Text(Image(systemName: "hand.raised.fingers.spread"))
                    Text("- After the five rounds of clues the game is over and you recieve your final score!")
                }
                .padding()
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    InformationView()
}
