//
//  ResultView.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/04.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var userData: UserData
    var withUnderScores: Bool?
    var questionAmount: Int?
    let letters: [Letters.Letter]
    var pickers: [Pickable]?
    let percent: Double


    var body: some View {
        VStack{
            Text("達成率" +
                String(
                    Int(percent)
                )
                + "%！"
            ).padding()
            Text("全問題数: " + String(self.questionAmount ?? self.letters.count))
            //Text("unqueestioned: " + String(self.userData.unQuestionedNums.count))
            //Text("next:" + String(self.userData.nextAnswerNum.count))
            Text("誤答数: " + String(userData.incorrectlyAnsweredLetters.count))
            NavigationLink(destination: ContentView(
                letters: letters,
                questionedLetters: userData.incorrectlyAnsweredLetters,
                pickers: pickers ?? letters,
                title: "間違えた文字だけをテスト"
            ).environmentObject(userData)){
                Text("間違えた文字だけをテストする").fontWeight(.heavy).foregroundColor(Color.blue).padding()
            }

            Spacer()
            LetterList(
                withUnderScores: self.withUnderScores,
                letters: letters,
                listedUpLetters: userData.incorrectlyAnsweredLetters,
                pickers: pickers ?? letters,
                title: "間違えた文字を復習しよう")
        }
        .navigationBarTitle("間違えた文字たち", displayMode: .inline)
    }
    
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        userData.incorrectlyAnsweredLetters =
            lettersData[0].letters
            //[
            //letterData[0],
            //letterData[1],
            //letterData[2]
        //]
        userData.unQuestionedLetters = []
        return ResultView(letters: lettersData[0].letters, percent: 0).environmentObject(userData)
    }
}
