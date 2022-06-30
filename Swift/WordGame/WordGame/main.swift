//
//  main.swift
//  WordGame
//
//  Created by Valters Steinblums on 12/02/2022.
//

import Foundation

struct setGameValues {
    var lifePoints: Int
    var attempt: Int
}

enum Command: String {
    case y
    case n
}

//MARK: - Setting game values

var initalGameValues = setGameValues(lifePoints: 6, attempt: 1)

var isAppRunning = true
let wordToGuessOptions: [String] = ["wordle", "toilet", "flower", "access", "second", "palace", "nation", "bottle", "aspect", "notice", "damage", "option", "autumn", "guitar", "ticket", "tenant", "gospel", "shield", "fusion", "census", "collar"]
var randomWordToGuess = wordToGuessOptions.randomElement()!
var randomWordToGuessAsArray = Array(randomWordToGuess)


// MARK: - Helper functions

// Prints if user enters less or more letters than the word has
func wrongGuessLenght(structCopy: inout setGameValues) {
    if (structCopy.lifePoints == 0) {
        print("Sorry, you ran out of attempts. The word was \"\(randomWordToGuess.uppercased())\".")
        endGame()
    } else {
        print("You should try a word with \(randomWordToGuess.count) letters.")
        print("You have \(structCopy.lifePoints) attempt(s) left.")
    }
}

// Just so theres is no need to retype math equations
func changeGameValues(structCopy: inout setGameValues) {
    structCopy.lifePoints -= 1
    structCopy.attempt += 1
}

// MARK: - Application code / functions

func welocmeMessage() {
    print("""
          --- WordGame ---
          
          Welcome to \"WordGame\", your task is to guess the provided word within \(initalGameValues.lifePoints) attempt(s)
          
          Rules:
          - If you provide a letter, which exists in the word, and the position is correct, then the game will print your letter as a capital (uppercase) letter (\"A\")
          - If you provide a letter, which exists in the word, but the position isn't correct, then the game will print your letter as a lowercase letter (\"a\")
          - If you provide a letter, which does not exist in this word, your letter will be replaced with the underscore (\"_\").
          
          --- Good luck! ---\n
          """)
}

func gameIsReady() {
    print("""
        Guess the word!
        You have \(initalGameValues.lifePoints) attempt(s).
        """)
    for _ in 1...initalGameValues.lifePoints {
        print("_", terminator: "")
    }
    print()
}

func endGame() {
    print("Play again? y - yes, n - no")
    if let newInput = readLine() {
        guard let command = Command.init(rawValue: newInput) else {
            print("No such command!")
            return endGame()
        }
        
        switch command {
        case .y:
            randomWordToGuess = wordToGuessOptions.randomElement()!
            randomWordToGuessAsArray = Array(randomWordToGuess)
            gameIsReady()
            game()
        case .n:
            isAppRunning = false
        }
    }
}

func game() {
    // copy of set game values, so I can modify them safely
    var changedGameValues = initalGameValues
    
    while isAppRunning {
        if let inputWord = readLine() {
            let inputWordAsArray = Array(inputWord)
            // checks if the word that user inputs is longer then given word
            if randomWordToGuessAsArray.indices.contains(inputWordAsArray.count - 1) {
                if (inputWord == randomWordToGuess) {
                    print("Congratulations! You guessed the word within \(changedGameValues.attempt) attempt(s)")
                    print(randomWordToGuess)
                    endGame()
                } else if (changedGameValues.lifePoints == 1) {
                    print("Sorry, you ran out of attempts. The word was \"\(randomWordToGuess.uppercased())\".")
                    endGame()
                } else {
                    var guess = ""
                    // checks if the word that user inputs is shorter then given word
                    if inputWordAsArray.indices.contains(randomWordToGuessAsArray.count - 1) {
                        // As both words are divided into char arrays, for loop checks every char.
                        for (i, char) in randomWordToGuessAsArray.enumerated() {
                            
                            // if char matches append to string "guess" with uppercase
                            if (char == inputWordAsArray[i]) {
                                guess.append(inputWordAsArray[i].uppercased())
                            
                            // if char matches, but in wrong position, append to given position lowercased
                            } else if (char != inputWordAsArray[i] && randomWordToGuessAsArray.contains(inputWordAsArray[i])) {
                                guess.append(inputWordAsArray[i].lowercased())
                            
                            // if no char matches append "_"
                            } else {
                                guess.append("_")
                            }
                        }
                        print(guess)
                        changeGameValues(structCopy: &changedGameValues)
                    } else {
                        // when user input is shorter than given word
                        changeGameValues(structCopy: &changedGameValues)
                        wrongGuessLenght(structCopy: &changedGameValues)
                    }
                }
            } else {
                // when user input is longer than given word
                changeGameValues(structCopy: &changedGameValues)
                wrongGuessLenght(structCopy: &changedGameValues)
            }
        }
    }
}

// MARK: - Calling functions in order, to run the game.

welocmeMessage()
gameIsReady()
game()
