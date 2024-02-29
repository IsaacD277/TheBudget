//
//  TitheTask.swift
//  TheBudget
//
//  Created by Isaac D2 on 2/28/24.
//

import SwiftUI

struct TitheTask: View {
    @State private var income: String = ""
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
                    HStack {
                        TextField("Paycheck Amount", text: $income)
                            .fontWeight(.bold)
                            .padding()
                            .textFieldStyle(.plain)
                            .disabled(true)
                        
                        Text("Calculate")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                donation += (Double(income) ?? 0.0) * 0.1
                                isDonated = false
                                focusIncome = false
                                income = ""
                            }
                    }
                    .padding(6)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 3)
                    )
                    .padding([.horizontal, .top])
                    .offset(y: focusIncome ? 0 : geometry.size.height / 2) // Slide down and out when not in focus
                    .animation(.bouncy, value: focusIncome)
                    
                    CustomNumberKeyboard(inputText: $income)
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
