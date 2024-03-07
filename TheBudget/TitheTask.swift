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
    @State private var investment: Double = 0.0
    @State private var focusIncome: Bool = true
    
    // Apple Monthly Expense Tracking
    @State private var appleName: String = "Apple One"
    @State private var appleDueDate: Int = 2
    @State private var appleMonthlyBill: Double = 6.93
    @State private var appleCurrentAmount: Double = 10.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView {
                    LazyVStack {
                        DonationConstant(donation: $donation)
                            .padding(.horizontal)
                        
                        InvestmentConstant(investment: $investment)
                            .padding(.horizontal)
                        
                        AppleOneConstant(Name: "Apple One")
                            .padding(.horizontal)
                        
                        AppleOneConstant(Name: "Spotify")
                            .padding(.horizontal)
                    }
                }
                    
                Spacer()
                
                // KEYBOARD AND INPUT
                VStack {
                    // INPUT
                    ZStack {
                        Text("$\(income ?? "0")")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .opacity(focusIncome ? 1.0 : 0.3)
                            .padding()
                            .onTapGesture {
                                focusIncome = true
                            }
                        
                        HStack {
                            Spacer()
                            
                            Image(systemName: "arrowshape.right")
                                .foregroundColor(.white)
                                .fontWeight(.black)
                                .padding()
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.trailing)
                                .onTapGesture {
                                    donation += (Double(income ?? "0.00") ?? 0.00) * 0.1
                                    investment += (Double(income ?? "0.00") ?? 0.00) * 0.05
                                    focusIncome = false
                                    income = nil
                                }
                                .opacity(focusIncome ? 1.0 : 0.0)
                        }
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
            .padding(.bottom)
        }
    }
}

#Preview {
    TitheTask()
}
