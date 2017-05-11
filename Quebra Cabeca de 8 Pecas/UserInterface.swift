//
//  SetupScreen.swift
//  Jogo8
//
//  Created by Clinton e Renan on 10/5/17.
//  Copyright © 2017. All rights reserved.
//

import Foundation

func setupScreen() -> () {
    ///Carrega a tabela inicial
    print("Tabela inicial: ", terminator:"")
    tryingToReadFirst:
        if let userInput = readLine(strippingNewline: true) {

        let stringTable = userInput.characters.map { String($0) }
        
        if stringTable.count != 9 {
            print("A tabela deve conter pelo menos 9 números")
            break tryingToReadFirst
        }

        var index = 0
        for i in 0..<3 {
            for j in 0..<3 {
                if var k = Int(stringTable[index]) {
                    
                    if k == 8 {
                        firstTableFromUser[i][j] = 0
                    } else if k == 0 {
                        firstTableFromUser[i][j] = 8
                    } else {
                        firstTableFromUser[i][j] = k
                    }
                    
                    index+=1
                } else {
                    print("Um dos termos da tabela não é um número")
                    break tryingToReadFirst
                }
            }
        }

        print("Tabela Carregada")
    } else {
        print("Error ao ler tabela")
    }


    ///Define a tabela final
    var index = 0
    for i in 0..<3 {
        for j in 0..<3 {
            
            if index == 8 {
                finalTableFromUser[i][j] = 0
            } else if index == 0 {
                finalTableFromUser[i][j] = 8
            } else {
                finalTableFromUser[i][j] = index
            }
            
            index += 1
        }
    }
}

func hasSolution(_ initialTable: [[Int]], finalTable: [[Int]]) -> Bool {
    
    var initialTableParity = 0
    var finalTableParity = 0
    
    for row in 0..<3 {
        for col in 0..<3 {
            let value = initialTable[row][col]
            
            for i in row..<3 {
                for j in 0..<3 {
                    let nextValue = initialTable[i][j]
                    
                    if (nextValue < value) && (nextValue != 0) && ( j > col || i > row ) {
                        initialTableParity+=1
                    }
                }
            }
        }
    }
    
    for row in 0..<3 {
        for col in 0..<3 {
            let value = finalTable[row][col]
            
            for i in row..<3 {
                for j in 0..<3 {
                    let nextValue = finalTable[i][j]
                    
                    if (nextValue < value) && (nextValue != 0) && ( j>col || i > row ) {
                        finalTableParity+=1
                    }
                }
            }
        }
    }
    
    return initialTableParity%2 == finalTableParity%2
    
}

func searchScreen() {

    if(!hasSolution(firstState.table, finalTable: finalState.table)) {
        print("Não foi possível encontrar uma solução")
        exit(0)
    }
}
