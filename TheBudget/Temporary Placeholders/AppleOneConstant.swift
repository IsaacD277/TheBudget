//
//  AppleOneConstant.swift
//  TheBudget
//
//  Created by Isaac D2 on 3/6/24.
//

import SwiftUI

struct AppleOneConstant: View {
    // Apple Monthly Expense Tracking
    @State private var name: String
    @State private var appleDueDate: Int = 2
    @State private var appleMonthlyBill: Double = 6.93
    @State private var appleCurrentAmount: Double = 5.0
    
    init(Name: String) {
        name = Name
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.blue)
                
                Spacer()
                
                // PROGRESS BAR
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(Color(red: 0.38, green: 0.61, blue: 0.54))
                        .clipShape(RoundedRectangle(cornerRadius: 30.0))
                    GeometryReader { geometry in
                        Rectangle()
                            .foregroundColor(.clear)
                        // This contains the progress bar if there is more in the account than the monthly bill costs
                            .frame(width: (appleCurrentAmount >= appleMonthlyBill) ? geometry.size.width : geometry.size.width * CGFloat(appleCurrentAmount / appleMonthlyBill))
                            .background(Color(red: 0.59, green: 0.93, blue: 0.83))
                            .clipShape(RoundedRectangle(cornerRadius: 30.0))
                    }
                    HStack {
                        Spacer()
                        Text(appleCurrentAmount, format: .currency(code: "USD"))
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 0.0, leading: 1, bottom: 0, trailing: 0.0))
                .frame(width: 170, height: 24)
            }
            
            HStack {
                Text((daysUntilDue() == 0) ? "Due today!" : (daysUntilDue() == 1) ? "Due in \(daysUntilDue()) day." : "Due in \(daysUntilDue(), format: .number) days")
                
                Spacer()
                
                Text("\(appleMonthlyBill, format: .currency(code: "USD"))/month")
            }
        }
        .padding(6)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 3)
        )
        .scaleEffect((appleCurrentAmount > 0.0) ? 1.0 : 0.0)
        .animation((appleCurrentAmount > 0.0) ? .spring(.bouncy, blendDuration: 0.2) : .easeOut, value: (appleCurrentAmount > 0.0))
        
        // Name, Due Date, Amount/month, currentAmount
        
        
        // Name       (_________________)
        // Due in 12 days     $6.93/month
    }
    
    func daysUntilDue() -> Int {
        let calendar = Calendar.current
        let currentDate = calendar.startOfDay(for: Date())
        
        // Get the current month and year
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        
        var dueDateComponents = DateComponents()
        dueDateComponents.year = currentYear
        dueDateComponents.month = currentMonth
        dueDateComponents.day = appleDueDate
        
        guard let dueDate = calendar.date(from: dueDateComponents) else {
            return 0
        }
        
        // Check if the due date is earlier than the current date
        if dueDate < currentDate {
            // If so, add one month to the current month
            dueDateComponents.month = currentMonth + 1
            // Recalculate due date
            if let nextMonthDueDate = calendar.date(from: dueDateComponents) {
                return calendar.dateComponents([.day], from: currentDate, to: nextMonthDueDate).day ?? 0
            } else {
                return 0
            }
        } else {
            // Calculate the difference in days between the current date and the due date
            return calendar.dateComponents([.day], from: currentDate, to: dueDate).day ?? 0
        }
    }
}

#Preview {
    AppleOneConstant(Name: "Apple One")
}
