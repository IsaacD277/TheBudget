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
    @State private var tappedKey: String?
    
    var body: some View {
        VStack(spacing: 1) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(row, id: \.self) { key in
                        if key == "," {
                            Button(action: {
                                // Remove the last character from the input text
                                if !inputText.isEmpty {
                                    tappedKey = key
                                    inputText.removeLast()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        tappedKey = nil
                                    }
                                }
                            }) {
                                Image(systemName: "delete.left")
                                    .font(.largeTitle)
                                    .fontWeight(.black)
                                    .frame(width: 115, height: 75)
                                    .foregroundColor(.blue)
                                    .scaleEffect(tappedKey == key ? 1.2 : 1.0) // Grow the tapped button
                                    .animation(.bouncy, value: tappedKey) // Add animation
                            }
                        } else {
                            Button(action: {
                                tappedKey = key
                                inputText += key
                                print("Button \(key) tapped")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    tappedKey = nil
                                }
                            }) {
                                Text(key)
                                    .font(.largeTitle)
                                    .fontWeight(.black)
                                    .frame(width: 115, height: 75)
                                    .foregroundColor(.blue)
                                    .scaleEffect(tappedKey == key ? 1.2 : 1.0) // Grow the tapped button
                                    .animation(.bouncy, value: tappedKey) // Disable default animation
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
