//
//  Letter.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/02.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import Foundation
import SwiftUI


struct Letter: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let script: String
    let sofit: Bool
    let dagesh: Bool
    let original: Int
    let description: String
}

