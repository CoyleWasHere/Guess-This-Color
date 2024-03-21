//
//  PlayView.swift
//  Hues and Clues
//
//  Created by Daniel Coyle on 3/20/24.
//

import SwiftUI

struct PlayView: View {
    
    var body: some View {
        VStack{
            LazyVGrid(columns: [GridItem(spacing:20), GridItem(spacing:20)], content: {
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color("a1"))
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color("b2"))
            })
        }
        .toolbar(.hidden, for: .navigationBar)
        
    }
}

#Preview {
    PlayView()
}
