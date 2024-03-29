//
//  InvestmentConstant.swift
//  TheBudget
//
//  Created by Isaac D2 on 3/6/24.
//

import SwiftUI

struct InvestmentConstant: View {
    @Binding var investment: Double
    
    var body: some View {
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
                }
        }
        .padding(6)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 3)
        )
        .scaleEffect((investment > 0.0) ? 1.0 : 0.0)
        .animation((investment > 0.0) ? .spring(.bouncy, blendDuration: 0.2) : .easeOut, value: (investment > 0.0))
    }
}

#Preview {
    let investment = Binding.constant(100.0)
    
    return InvestmentConstant(investment: investment)
}
