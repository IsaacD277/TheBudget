//
//  DonationConstant.swift
//  TheBudget
//
//  Created by Isaac D2 on 3/6/24.
//

import SwiftUI

struct DonationConstant: View {
    @Binding var donation: Double
    
    var body: some View {
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
//                                    if donation <= 0.0 && investment <= 0.0 {
//                                        focusIncome = true
//                                    }
                }
        }
        .padding(6)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 3)
        )
        .scaleEffect((donation > 0.0) ? 1.0 : 0.0)
        .animation((donation > 0.0) ? .spring(.bouncy, blendDuration: 0.2) : .easeOut, value: (donation > 0.0))
    }
}

//#Preview {
//    DonationConstant()
//}
