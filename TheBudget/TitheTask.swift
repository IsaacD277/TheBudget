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
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if donation > 0.0 {
                    HStack {
                        Text(donation, format: .currency(code: "USD"))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.blue)
                        
                        Spacer()
                        
                        Text("I Donated")
                            .foregroundStyle(Color.white)
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                donation = 0.0
                                if donation <= 0.0 && investment <= 0.0 {
                                    focusIncome = true
                                }
                            }
                    }
                    .frame(width: geometry.size.width * 0.8)
                    .padding(6)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .background(
                         RoundedRectangle(cornerRadius: 15)
                             .stroke(Color.gray, lineWidth: 3)
                     )
                    .padding(6)
                }
                 
                if investment > 0.0 {
                    HStack {
                        Text(investment, format: .currency(code: "USD"))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.blue)
                        
                        Spacer()
                        
                        Text("I Invested")
                            .foregroundStyle(Color.white)
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                investment = 0.0
                                if donation <= 0.0 && investment <= 0.0 {
                                    focusIncome = true
                                }
                            }
                    }
                    .frame(width: geometry.size.width * 0.8)
                    .padding(6)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .background(
                         RoundedRectangle(cornerRadius: 15)
                             .stroke(Color.gray, lineWidth: 3)
                     )
                    .padding(6)
                }
                
                Spacer()
                
                VStack {
                    VStack {
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
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    TitheTask()
}
