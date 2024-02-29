//
//  TitheTask.swift
//  TheBudget
//
//  Created by Isaac D2 on 2/28/24.
//

import SwiftUI

struct TitheTask: View {
    @State private var income: String?
    @State private var donation: Double = 0.0
    @State private var isDonated: Bool = true
    @State private var focusIncome: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if !isDonated {
                    HStack {
                        Text("Donate: \(donation, format: .currency(code: "USD"))")
                            .font(.title)
                        Button(action: {
                            isDonated = true
                            donation = 0.0
                            focusIncome = true
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    VStack {
                        Text("$\(income ?? "0")")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .opacity(focusIncome ? 1.0 : 0.3)
                            .padding()
                            .onTapGesture {
                                focusIncome = true
                            }
                        
                        Text("Calculate")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                donation += (Double(income ?? "0.00") ?? 0.00) * 0.1
                                isDonated = false
                                focusIncome = false
                                income = nil
                            }
                    }
                    .padding([.horizontal, .top])
                    .offset(y: focusIncome ? 0 : geometry.size.height / 2) // Slide down and out when not in focus
                    .animation(.bouncy, value: focusIncome)
                    
                    CustomNumberKeyboard(inputText: Binding(
                        get: { income ?? "" },
                        set: { income = $0 }
                    ))
                    .offset(y: focusIncome ? 0 : geometry.size.height / 1.8) // Slide down and out when not in focus
                    .animation(.bouncy, value: focusIncome)
                }
            }
            .padding(.bottom, geometry.safeAreaInsets.bottom)
        }
    }
}

#Preview {
    TitheTask()
}
