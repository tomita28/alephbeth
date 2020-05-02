//
//  UserData.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/02.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

import Combine

final class UserData: ObservableObject  {
    let letters = letterData
    @Published var incorrectlyAnsweredLetters: [Letter] = []
    @Published var unQuestionedNums: [Int] = []
    func completedRate () -> Double {
        let unAnswered = unQuestionedNums.count
        let completed = letters.count - incorrectlyAnsweredLetters.count - unAnswered
        let rate = Double(completed) / Double(letters.count)
        let percent = rate * 100.0
        return percent
    }
    @Published var percent: Double = 0.0
}
