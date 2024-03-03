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
    @State private var appleDueDate: Int = 3
    @State private var appleMonthlyBill: Double = 6.93
    @State private var appleCurrentAmount: Double = 10.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // DONATION
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
                .scaleEffect((donation > 0.0) ? 1.0 : 0.0)
                .animation((donation > 0.0) ? .spring(.bouncy, blendDuration: 0.2) : .easeOut, value: (donation > 0.0))
                 
                // INVESTMENT
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
                .scaleEffect((investment > 0.0) ? 1.0 : 0.0)
                .animation((investment > 0.0) ? .spring(.bouncy, blendDuration: 0.2) : .easeOut, value: (investment > 0.0))
                
                // APPLE ONE
                HStack {
                    VStack(alignment: .leading) {
                        Text(appleName)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.blue)
                        
                        // Shows how many days until the bill's due date
                        Text((daysUntilDue() == 0) ? "Due today!" : "Due in \(daysUntilDue(), format: .number) days")
                    }
                    
                    VStack(alignment: .trailing) {
                        VStack {
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
                            .padding()
                            // .frame(width: 200, height: 20)
                        }
                        // Text(appleCurrentAmount, format: .currency(code: "USD"))
                        Text("\(appleMonthlyBill, format: .currency(code: "USD"))/month")
                    }
                }
                .frame(width: geometry.size.width * 0.8)
                
                // Name, Due Date, Amount/month, currentAmount
                
                
                // Name       (_________________)
                // Due in 12 days     $6.93/month
                
                Spacer()
                
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
    TitheTask()
}
