//
//  SearchTree.swift
//  Quebra Cabeca de 8 Pecas
//
//  Created by Clinton de Sá Barreto Maciel on 10/05/17.
//  Copyright © 2017 Clinton Barreto. All rights reserved.
//

import Foundation
func aStartSort (_ lhs: State, rhs: State) -> Bool {
    
    return lhs.cost + lhs.depth  <  rhs.cost + rhs.depth
    
}

func generateChild(_ currentState: State) -> ([State]) {
    var newStates = [State]()
    
    //Coordenates of blank position
    let x = currentState.blank_position_x
    let y = currentState.blank_position_y
    
    //move célula em branco para a esquerda
    if y>0 {
        //tabela auxiliar que começa como sendo copia da original
        var aux_table = currentState.table
        //move célula
        aux_table[x][y]=aux_table[x][y-1]
        aux_table[x][y-1]=0
        //adiciona tabela à lista
        let auxState = State(table: aux_table, parent: currentState, move: "Esquerda", depth: currentState.depth+1, cost: getCostTo(aux_table),
                             blank_position_x: currentState.blank_position_x, blank_position_y: currentState.blank_position_y-1)
        newStates.append(auxState)
        generatedNodes+=1
    }
    
    //move célula em branco para a direita
    if y<2 {
        //tabela auxiliar que começa como sendo copia da original
        var aux_table = currentState.table
        //move célula
        aux_table[x][y]=aux_table[x][y+1]
        aux_table[x][y+1]=0
        //adiciona tabela à lista
        let auxState = State(table: aux_table, parent: currentState, move: "Direita", depth: currentState.depth+1, cost: getCostTo(aux_table),
                             blank_position_x: currentState.blank_position_x, blank_position_y: currentState.blank_position_y+1)
        newStates.append(auxState)
        generatedNodes+=1
    }
    
    //move célula em branco para cima
    if x>0 {
        //tabela auxiliar que começa como sendo copia da original
        var aux_table = currentState.table
        //move célula
        aux_table[x][y]=aux_table[x-1][y]
        aux_table[x-1][y]=0
        //adiciona tabela à lista
        let auxState = State(table: aux_table, parent: currentState, move: "Cima", depth: currentState.depth+1, cost: getCostTo(aux_table),
                             blank_position_x: currentState.blank_position_x-1, blank_position_y: currentState.blank_position_y)
        newStates.append(auxState)
        generatedNodes+=1
    }
    
    //move célula em branco para baixo
    if x<2 {
        //tabela auxiliar que começa como sendo copia da original
        var aux_table = currentState.table
        //move célula
        aux_table[x][y]=aux_table[x+1][y]
        aux_table[x+1][y]=0
        //adiciona tabela à lista
        let auxState = State(table: aux_table, parent: currentState, move: "Baixo", depth: currentState.depth+1, cost: getCostTo(aux_table),
                             blank_position_x: currentState.blank_position_x+1, blank_position_y: currentState.blank_position_y)
        newStates.append(auxState)
        generatedNodes+=1
    }
    
    
    return newStates
}

func findCoordinates(_ number: Int, matrix: [[Int]]) -> (row: Int, col: Int)? {
    for i in 0..<3 {
        for j in 0..<3 {
            if matrix[i][j]==number {
                return (i,j)
            }
        }
    }
    return nil
}

func manhantanDistance(_ n:Int,currentTable: [[Int]] ) -> (Int)? {
    
    if let (x1,y1) = findCoordinates(n, matrix: currentTable), let (x2,y2) = findCoordinates(n, matrix: finalState.table){
        return abs(x1-x2) + abs(y1-y2)
    }
    
    // If the coordinates can't be found the distance can't be calculated
    return nil
}

func getCostTo(_ currentTable: [[Int]]) -> (Int) {
    
    var totalCost = 0
    
    for i in 0...8 {
        if let distance = manhantanDistance(i, currentTable: currentTable) {
               totalCost+=distance
        }
        else {
            return 0
        }
    }
    
    
    return totalCost
}

func isSolution(_ someState: State, finalState: State) -> (Bool) {
    return someState.table == finalState.table
}

func aStarSearch() -> (State){
    
    var stateList = PriorityQueue<State>(sort: aStartSort)
    
    stateList.enqueue(firstState)
    
    while !stateList.isEmpty {
        
        if let state = stateList.dequeue(){
            
            if isSolution(state, finalState: finalState) {
                return state
            }
            
            let childList = generateChild(state)
            
            for child in childList {
                if !visitedStates.contains(child) {
                    stateList.enqueue(child)
                    visitedStates.insert(child)
                    passedByNodes+=1
                    if passedByNodes % 1000 == 0 { print (passedByNodes) }
                }
            }
            
        }
        
    }
    
    return firstState
}
