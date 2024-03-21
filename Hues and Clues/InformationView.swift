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
                    Text(" - Each Game consists of three clues")
                    Text(" - The first clue will be shown at the top of the screen and you must guess what color you think it is.")
                    Text(" - If you guess the correct color, you get 3 points, ")
                    Text(" - FIf you are one square away, you get 2 points")
                    Text(" - If you are two squares away, you get 1 point ")
                    Text(" - and 3 or more  squares away is no points.")
                    Text(" - AAfter the three rounds of clues the game is over and you recieve your final score!")
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    InformationView()
}
