//
//  ContentView.swift
//  WordScramble
//
//  Created by Sreekutty Maya on 21/04/2024.
//

import SwiftUI

struct ContentView: View {
   @State var usedWords : [String] = []
   @State var rootWord : String = ""
   @State var newWord : String = ""

    var body: some View {
        NavigationStack {
            Section {
                TextField("Enter a word here", text: $newWord).textInputAutocapitalization(.never)
            }
            
            List {
                ForEach(usedWords,id:\.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text("\(word)")
                    }
                }
            }
        }.navigationTitle($rootWord)
            .onSubmit {
                addNewWord()
            }
        
       
    }
    
    func addNewWord() {
        let trimmedWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if(trimmedWord.count > 0) {
            withAnimation {
                usedWords.insert(trimmedWord, at: 0)

            }
        }
        newWord = ""
    }
}

#Preview {
    ContentView()
}
