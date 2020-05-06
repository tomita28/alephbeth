//
//  ResultView.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/04.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var userData: UserData
    let letters: [Letter] = letterData
    let names = ["John", "Apple", "Seed"]
    let percent: Double


    var body: some View {
        VStack{
            Text("達成率" +
                String(
                    Int(percent)
                )
                + "%！"
            ).padding()
            Text("全問題数: " + String(self.letters.count))
            //Text("unqueestioned: " + String(self.userData.unQuestionedNums.count))
            //Text("next:" + String(self.userData.nextAnswerNum.count))
            Text("誤答数: " + String(userData.incorrectlyAnsweredLetters.count))
            

            Spacer()
            LetterList(letters: userData.incorrectlyAnsweredLetters)
        }
        .navigationBarTitle("間違えた文字たち", displayMode: .inline)
    }
    
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        userData.incorrectlyAnsweredLetters =
            letterData
            //[
            //letterData[0],
            //letterData[1],
            //letterData[2]
        //]
        userData.unQuestionedNums = []
        return ResultView(userData: userData, percent: 0)
    }
}
