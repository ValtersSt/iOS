//
//  main.swift
//  Groceries
//
//  Created by Valters Steinblums on 05/02/2022.
//

import Foundation

enum Command: String {
    case l
    case a
    case r
    case s
    case h
    case q
    case endOfFile = "EOF"
    case random
    case indexes
}

struct Product {
    private static var nextID: Int = 1
    
    let id: Int
    var name: String
    var quantity: String
    
    init(name: String, quantity: String) {
        self.name = name
        self.quantity = quantity
        self.id = Self.nextID // Use Self to access private static properties
        Self.nextID += 1
    }
}


func printWelcomeMessage() {
    print("---- Your Grocery list ----")
    print("To see available commands, type \"h\"")
}

func printCommands() {
    print("Available commands:")
    print("\tl - Show grocery list")
    print("\ta - Add new product")
    print("\tr - Remove product")
    print("\ts - Sort products")
    print("\th - Help")
    print("\tq - Quit")
}

func listProducts() {
    print("--- Grocery List ---")
    print("Product count: \(products.count)")
    
    for product in products {
        print("ID: \(product.id), Product: \(product.name), Quantity: \(product.quantity)")
    }
}

func addProduct() {
    print("--- Add Product ---")
    let productName = readLine(after: "Enter name: ")
    let quantity = readLine(after: "Enter quantity: ")
    
    if productName.isEmpty == false {
        let product = Product.init(name: productName, quantity: quantity)
        products.append(product)
        
        print("\(product.quantity) ,\(product.name) was added to the list!")
    } else {
        print("Product name was empty, didn't add anything...")
    }
    
}

func removeProduct() {
    let id = readLine(after: "Enter product ID to remove: ")
    
    for (index, product) in products.enumerated() {
        if product.id == Int(id) {
            products.remove(at: index)
            print("Removed \(product.name) from the list!")
        }
    }
}

func readLine(after message: String) -> String {
    print(message, terminator: "")
    
    // There is a possibility to receive a nil value.
    // To simulate -> while running ctrl + D
    if let input = readLine() {
        return input.trimmingCharacters(in: .whitespaces)
    } else {
        // EOF -> end of file
        return "EOF"
    }
}

// MARK: - Application code

var isAppRunning = true

var products: [Product] = []

printWelcomeMessage()
printCommands()

while(isAppRunning) {

    let inputCommand = readLine(after: "Enter command: ")
    
    // convert input command String to Command enum
    guard let command = Command.init(rawValue: inputCommand) else {
        // command does not exist here
        print("\(inputCommand): command not found")
        continue
    }
    // command exists here
    print("Received command: \(command)")
    
    switch command {
    case .l:
        // show product list
        listProducts()
    case .a:
        // add new product
        addProduct()
    case .r:
        // remove product
        removeProduct()
    case .s:
        // sort product
        break
    case .h:
        // help
        printCommands()
    case .q, .endOfFile:
        // quit
        isAppRunning = false
    case .random:
        if let product = products.randomElement() {
            print("You should now buy a \(product.name)")
        } else {
            print("You have already bought everything, gfy!")
        }
    case .indexes:
        let countries = ["Latvia" ,"USA", "Iceland"]
        //print(countries[0]) // Latvia
        //print(countries[6]) // Out of bounds -> crash
        
        if countries.indices.contains(2) {
            print("Yeah")
            print(countries[2])
        } else {
            print("nah")
        }
    }
}
