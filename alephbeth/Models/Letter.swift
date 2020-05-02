//
//  Letter.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/02.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import Foundation
import SwiftUI


struct Letter: Hashable, Codable {
    var id: Int
    var name: String
    var script: String
    var sofit: Bool
    var dagesh: Bool
}
