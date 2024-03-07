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
    @State private var investment: Double = 0.0
    @FocusState private var focusIncome: Bool
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    AppleOneConstant(Name: "Apple One")
                        .padding(.horizontal)
                    
                    AppleOneConstant(Name: "Spotify")
                        .padding(.horizontal)
                    
                    DonationConstant(donation: $donation)
                        .padding(.horizontal)
                    
                    InvestmentConstant(investment: $investment)
                        .padding(.horizontal)
                    
                    // IF income ends up being optional
//                        TextField("Paycheck Amount", text: Binding(
//                            get: { income ?? "" },
//                            set: { income = $0 }
//                        ))
                    
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .scrollIndicators(.never)
            
            Spacer()
            
            ZStack {
                TextField("Amount", text: $income)
                    .inputView {
                        CustomNumberKeyboard(inputText: $income)
                    }
                    .multilineTextAlignment(.center)
                    .focused($focusIncome)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.horizontal)
                
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
                            donation += (Double(income) ?? 0.00) * 0.1
                            investment += (Double(income) ?? 0.00) * 0.05
                            focusIncome = false
                            income = ""
                        }
                }
            }
        }
    }
}
                    

#Preview {
    TitheTask()
}
