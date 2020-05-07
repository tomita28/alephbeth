//
//  Letters.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/06.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import Foundation

struct Letters: Decodable{
    let language: String
    let scripttype: String
    let name: String
    let pickers: [Picker]?
    let letters: [Letter]
    
    struct Picker: Pickable, Decodable {
        let id: Int
        let name: String
    }
 
    struct Letter: Pickable, Decodable{
        let id: Int
        let name: String
        let answerId: Int?
        let script: String
        let sofit: Bool?
        let dagesh: Bool?
        //派生文字の場合、派生元の文字のidを入れる。
        let original: Int?
        let pronunciation: String?
        let explanation: String
    }
}

protocol Pickable {
    var id: Int {get}
    var name: String {get}
}
