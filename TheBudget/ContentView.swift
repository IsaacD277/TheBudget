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
                Text("Here is a budgeting app that I'm making")
                
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
