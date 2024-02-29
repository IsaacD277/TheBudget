//
//  Custom Keyboard.swift
//  TheBudget
//
//  Created by Isaac D2 on 2/28/24.
//

import SwiftUI

struct CustomNumberKeyboard: View {
    let rows = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", ","]
    ]
    
    @Binding var inputText: String
    
    var body: some View {
        VStack(spacing: 1) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(row, id: \.self) { key in
                        if key == "," {
                            Button(action: {
                                // Remove the last character from the input text
                                if !inputText.isEmpty {
                                    inputText.removeLast()
                                }
                            }) {
                                Image(systemName: "delete.left")
                                    .font(.largeTitle)
                                    .fontWeight(.black)
                                    .frame(width: 115, height: 75)
                                    .foregroundColor(.blue)
                            }
                        } else {
                            Button(action: {
                                inputText += key
                                print("Button \(key) tapped")
                            }) {
                                Text(key)
                                    .font(.largeTitle)
                                    .fontWeight(.black)
                                    .frame(width: 115, height: 75)
                                    .foregroundColor(.blue)
                                    // .background(Color.red)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

//#Preview {
//    CustomNumberKeyboard(inputText: <#T##Binding<String>#>)
//}
