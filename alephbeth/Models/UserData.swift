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
    let letters = lettersData[0].letters
    @Published var incorrectlyAnsweredLetters: [Letters.Letter] = []
    @Published var unQuestionedLetters: [Letters.Letter] = []
    @Published var nextAnswerLetter: [Letters.Letter] = []
}
