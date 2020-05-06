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
    @Published var nextAnswerNum: [Int] = []
}
