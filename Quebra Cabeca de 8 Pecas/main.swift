//
//  main.swift
//  Quebra Cabeca de 8 Pecas
//
//  Created by Clinton de Sá Barreto Maciel on 10/05/17.
//  Copyright © 2017 Clinton Barreto. All rights reserved.
//

import Foundation

var firstTableFromUser = Array(repeating: Array(repeating: 0, count: 3), count: 3)
var finalTableFromUser = Array(repeating: Array(repeating: 0, count: 3), count: 3)

/// Display the Setup Screen
setupScreen()

/// List to Store visited States
var visitedStates = Set<State>()

var index_i = 0
var index_j = 0

/// Find blank position for the initial state
for i in 0..<3 {
    for j in 0..<3 {
        if firstTableFromUser[i][j] == 0 {
            index_i = i
            index_j = j
        }
    }
}

/// Create Initial State
let firstState = State(
    table: firstTableFromUser,
    parent: nil,
    move: nil,
    depth: 0,
    cost: 0,
    blank_position_x: index_i,
    blank_position_y: index_j
)


index_i = 0
index_j = 0

/// Find blank position for the Final State
for i in 0..<3 {
    for j in 0..<3 {
        if finalTableFromUser[i][j] == 0 {
            index_i=i
            index_j=j
        }
    }
}

/// Create Final State
let finalState = State(
    table: finalTableFromUser,
    parent: nil,
    move: nil,
    depth: 0,
    cost: 0,
    blank_position_x: index_i,
    blank_position_y: index_j
)

print("Tabela inicial: ")
firstState.prettyPrint()
print("Objetivo da tabela final: ")
finalState.prettyPrint()

var passedByNodes = 0
var generatedNodes = 0

if hasSolution(firstTableFromUser, finalTable: finalTableFromUser) {
    
    solve()
} else {
    
    print("Tabela sem solução desejada")
}



