//
//  QuizData.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/06/04.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

import SwiftUI

import Combine

final class QuizData: ObservableObject  {
    //let letters = lettersData[0].letters
    @Published var incorrectlyAnsweredLetters: [Letters.Letter] = []
    @Published var unQuestionedLetters: [Letters.Letter] = []
    @Published var nextAnswerLetter: [Letters.Letter] = []
}
