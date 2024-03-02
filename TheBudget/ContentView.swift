//
//  ContentView.swift
//  TheBudget
//
//  Created by Isaac D2 on 2/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                    .fontWeight(.light)
                Text("This is a simple budgeting app")
                    .fontWeight(.bold)
                    .padding(6)
                
                NavigationLink(destination: TitheTask()) {
                    Text("Get Started!")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
