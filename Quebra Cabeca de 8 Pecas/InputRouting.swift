//
//  Input.swift
//  Jogo8
//
//  Created by Raul Ferreira on 2/27/16.
//  Copyright © 2016 FCUP. All rights reserved.
//

import Foundation

func solve() {

    let start = Date()

    let answer = aStarSearch()
    
    let end = Date()
    let timeInterval: Double = end.timeIntervalSince(start)

    print("Tempo decorrido: \(timeInterval) seconds");

    //print(answer)

    print("Númerod de moviventos: \(answer.depth)")
    
    answer.printPath()
}
