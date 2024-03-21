//
//  DataService.swift
//  Hues and Clues
//
//  Created by Daniel Coyle on 3/20/24.
//

import Foundation
import SwiftUI

struct DataService {
    func getClues() -> [String:String] {
        return ["Potato":"b1",
                "Mountain Dew": "e8",
                "Apple":"a6"]
    }
    func colorPallette() -> [Color] {
        return [
            Color("a1"),
            Color("a2"),
            Color("a3"),
            Color("a4"),
            Color("a5"),
            Color("a6"),
            Color("a7"),
            Color("a8"),
            Color("a9"),
            Color("a10"),
            Color("a11"),
            Color("a12"),
            Color("a13"),
            Color("a14"),
            Color("b1"),
            Color("b2"),
            Color("b3"),
            Color("b4"),
            Color("b5"),
            Color("b6"),
            Color("b7"),
            Color("b8"),
            Color("b9"),
            Color("b10"),
            Color("b11"),
            Color("b12"),
            Color("b13"),
            Color("b14"),
            Color("c1"),
            Color("c2"),
            Color("c3"),
            Color("c4"),
            Color("c5"),
            Color("c6"),
            Color("c7"),
            Color("c8"),
            Color("c9"),
            Color("c10"),
            Color("c11"),
            Color("c12"),
            Color("c13"),
            Color("c14"),
            Color("d1"),
            Color("d2"),
            Color("d3"),
            Color("d4"),
            Color("d5"),
            Color("d6"),
            Color("d7"),
            Color("d8"),
            Color("d9"),
            Color("d10"),
            Color("d11"),
            Color("d12"),
            Color("d13"),
            Color("d14"),
            Color("e1"),
            Color("e2"),
            Color("e3"),
            Color("e4"),
            Color("e5"),
            Color("e6"),
            Color("e7"),
            Color("e8"),
            Color("e9"),
            Color("e10"),
            Color("e11"),
            Color("e12"),
            Color("e13"),
            Color("e14")
        ]
    }
    
    func colorName() -> [String]{
        return [
        "a1",
        "a2",
        "a3",
        "a4",
        "a5",
        "a6",
        "a7",
        "a8",
        "a9",
        "a10",
        "a11",
        "a12",
        "a13",
        "a14",
        "b1",
        "b2",
        "b3",
        "b4",
        "b5",
        "b6",
        "b7",
        "b8",
        "b9",
        "b10",
        "b11",
        "b12",
        "b13",
        "b14",
        "c1",
        "c2",
        "c3",
        "c4",
        "c5",
        "c6",
        "c7",
        "c8",
        "c9",
        "c10",
        "c11",
        "c12",
        "c13",
        "c14",
        "d1",
        "d2",
        "d3",
        "d4",
        "d5",
        "d6",
        "d7",
        "d8",
        "d9",
        "d10",
        "d11",
        "d12",
        "d13",
        "d14",
        "e1",
        "e2",
        "e3",
        "e4",
        "e5",
        "e6",
        "e7",
        "e8",
        "e9",
        "e10",
        "e11",
        "e12",
        "e13",
        "e14"
    ]
    }
}
