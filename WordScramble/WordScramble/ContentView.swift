//
//  ContentView.swift
//  WordScramble
//
//  Created by Sreekutty Maya on 21/04/2024.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        List {
            Section {
                Text("Hello")
                Text("Hello")
            }
            Section {
                ForEach(0..<2) {_ in
                    Text("Inside Hello")
                }
            }
            Section {
                Text("Hello")
                Text("Hello")
            }

        }.listStyle(.insetGrouped)
        
        List(people, id:\.self) {
            Text("Hello \($0)")
        }
         
        
        List {
            Section {
                Text("Hello")
                Text("Hello")
            }
            Section {
                ForEach(people,id:\.self) {
                    Text("Hello \($0)")
                }
            }
            Section {
                Text("Hello")
                Text("Hello")
            }

        }
       
    }
}

#Preview {
    ContentView()
}
