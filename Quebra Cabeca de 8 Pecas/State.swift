//
//  search.swift
//  Jogo8
//
//  Created by Raul Ferreira on 2/22/16.
//  Copyright © 2016 FCUP. All rights reserved.
//

import Foundation

class State {
    let table: [[Int]]
    let parent: State?
    let move: String?
    let depth: Int
    let cost: Int
    let blank_position_x: Int
    let blank_position_y: Int

    init(table: [[Int]], parent: State?, move: String?, depth: Int, cost: Int, blank_position_x: Int, blank_position_y: Int) {
        self.table = table
        self.depth = depth
        self.move = move
        self.parent = parent
        self.blank_position_x = blank_position_x
        self.blank_position_y = blank_position_y
        self.cost = cost
    }

    func printPath() {
        var nodeToPrint: State? = self

        while nodeToPrint != nil {

            nodeToPrint!.prettyPrint()
            print()

            if let move = nodeToPrint!.move {
                print("Mova: \(move)")
                print()
            }

            nodeToPrint = nodeToPrint!.parent

        }

    }

    func prettyPrint() {
        print("+-----+")
        for i in 0..<3 {
            print("|", terminator:"")
            for j in 0..<2 {
                if table[i][j] == 8 {
                    print("0", terminator:" ")
                }else if table[i][j] == 0 {
                    print(" ", terminator: " ")
                } else {
                    print(table[i][j], terminator:" ")
                }
            }
            
            if table[i][2] == 8 {
                print("0", terminator: "|\n")
            } else if table[i][2] == 0 {
                print(" ", terminator: "|\n")
            }else {
                print(table[i][2], terminator: "|\n")
            }
        }
        print("+-----+")
    }

}

extension State: CustomStringConvertible {

    var description: String {
        return "{ Tabela:  \(table) } "
    }

}

extension State: Hashable {

    var hashValue: Int {
        return description.hashValue
    }

}

extension State: Equatable {}

func == (lhs: State, rhs: State) -> Bool {
    return lhs.table == rhs.table
}


func tableAndDepthEquality (_ lhs: State, rhs: State) -> Bool {
    return lhs.table == rhs.table && lhs.depth == rhs.depth
}


// Makes multi-dementional Arrays Equatable
func == (lhs: [[Int]], rhs: [[Int]]) -> Bool{

    if lhs.count != rhs.count{
        return false
    }

    let count = lhs.count

    for i in 0..<count{
        if lhs[i] != rhs[i] {
            return false
        }
    }
    
    return true
}


