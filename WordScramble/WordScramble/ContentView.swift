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
    @State var wordErroralertTitle : String = ""
    @State var wordErrorDescirption : String = ""
    @State var showAlert : Bool = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        Text(word)
                    }
                }
                
                
            }  .navigationTitle($rootWord)
                .onSubmit({
                    guard  isOriginalWord(word: newWord.lowercased()) else {
                    wordError(title: "Word used already", message: "Be more original")
                        return
                    }
                    guard isPossibleWord(word: newWord.lowercased()) else {
                        wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
                        return
                    }

                    guard isReal(word:newWord.lowercased()) else {
                        wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
                        return
                    }
                    addNewWord()
                })
               .onAppear(perform: startGame)
        }.alert(wordErroralertTitle, isPresented: $showAlert) {}  message: {
            Text(wordErrorDescirption)
        }
    }
    
    func isOriginalWord(word:String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossibleWord(word:String) -> Bool {
        var tempWord = rootWord
            for letter in word {
                if let pos = tempWord.firstIndex(of: letter) {
                    tempWord.remove(at: pos)
                } else {
                    return false
                }
            }

            return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        wordErroralertTitle = title
        wordErrorDescirption = message
        showAlert = true
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
    
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                
                let words = startWords.split(separator: "\n")
                rootWord = String(words.randomElement() ?? "elikson")
            }

            
        }

    }
}

#Preview {
    ContentView()
}
