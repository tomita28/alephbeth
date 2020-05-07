//
//  ContentView.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/01.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var withUnderScores: Bool?
    let letters: [Letters.Letter]
    let pickers: [Pickable]
    let title: String
    
    @ObservedObject var userData = UserData()
    
    @State var selection = 0
    @State var submitted = false
    @State var isCorrect = false
    @State var answerLetter: Letters.Letter? = nil
    
    var body: some View {
        VStack {
            Text(answerLetterScript())
                .font(.largeTitle).padding()
            Text("これの読み方は？")
                .font(.subheadline)
            Picker(selection: $selection, label: Text("")) {
                ForEach(0..<pickers.count){ num in
                    Text(self.pickers[num].name)
                }
            }
            .labelsHidden()

            HStack{
                
                //まだこの問題に対して回答していない時
                if(!self.submitted){
                    //回答ボタン有効
                    Button(action: {
                        //正誤をチェック
                        let answerId: Int? = self.answerLetter.map{$0.answerId ?? $0.id}
                        self.isCorrect = answerId.map{$0 == self.pickers[self.selection].id} ?? false
                        //未出題の問題を一つ削って次の解答へ入れる
                        self.setNextAnswer ()
                        //間違っていたら誤回答リストに加える
                        if(!self.isCorrect){
                            self.addIncorrectAnswer()
                        }
                        //回答提出済み
                        self.submitted = true
                    }) {
                        Text("回答")
                            .padding()
                    }
                //回答済みなのでボタン無効
                }else{
                    Text("回答")
                        .foregroundColor(Color.gray)
                        .padding()
                }
                
                /*
                //まだ残りの問題がある時
                if(self.userData.unQuestionedLetters.count > 0){
                    //次へボタン有効
                    Button(action: {
                        //未回答のまま次の問題に行ったらこの問題を誤答リストに加える
                        if(!self.submitted){
                            self.addIncorrectAnswer()
                            //未出題の問題を一つ削って次の解答へ入れる
                            self.setNextAnswer()
                        }
                        self.submitted = false
                        self.isCorrect = false
                        self.answerLetter = self.userData.nextAnswerLetter.popLast()
                        })
                    {
                        Text("次へ")
                            .padding()
                    }
                //もう残りの問題はないので次へボタン無効
                }else{
                    Text("次へ")
                        .foregroundColor(Color.gray)
                        .padding()
                }
 */
            }
            Spacer()
            if(self.userData.unQuestionedLetters.count >= 0){
                Text("あと" + String(unAnswered()) + "問あるよ")
            }else{
                Text("もうないよ")
            }
            
            Spacer()
            
            if (self.submitted){
                if(self.isCorrect){
                    Text("正解")
                }else{
                    Text("不正解！正解は↓")
                    Spacer()
                    Text(self.answerLetterName())
                    .bold()
                }
            }
            
            Spacer()
            HStack{
                NavigationLink(destination: ResultView(
                    userData: userData,
                    withUnderScores: self.withUnderScores,
                    letters: letters,
                    pickers: pickers,
                    percent: self.completedRate())) {
                    Text("結果を見る")
                }
                Spacer()
                Button(action: {self.resetQuetions()})
                {
                    Text("最初から")
                }
                Spacer()
                //まだ残りの問題がある時
                if(self.userData.unQuestionedLetters.count > 0){
                    //次へボタン有効
                    Button(action: {
                        //未回答のまま次の問題に行ったらこの問題を誤答リストに加える
                        if(!self.submitted){
                            self.addIncorrectAnswer()
                            //未出題の問題を一つ削って次の解答へ入れる
                            self.setNextAnswer()
                        }
                        self.submitted = false
                        self.isCorrect = false
                        self.answerLetter = self.userData.nextAnswerLetter.popLast()
                        })
                    {
                        Text("次へ")
                            .padding()
                    }
                //もう残りの問題はないので次へボタン無効
                }else{
                    Text("次へ")
                        .foregroundColor(Color.gray)
                        .padding()
                }
            }
        }
        .padding()
        .onAppear(perform: resetQuetions)
        .navigationBarTitle(Text(self.title), displayMode: .inline)
    }

    
    func answerLetterName () -> String {
        let answerId = self.answerLetter.map{$0.answerId ?? $0.id}
        let correctPicker = pickers.filter{$0.id == answerId}.first
        return correctPicker?.name ?? "選択肢の答えがないよ"
    }
    func answerLetterScript () -> String {
        self.answerLetter.map{$0.script} ?? "答えがないよ"
    }
    
    func resetQuetions () {
        self.userData.incorrectlyAnsweredLetters = []
        self.userData.unQuestionedLetters = letters
        self.userData.unQuestionedLetters.shuffle()
        if let pop = self.userData.unQuestionedLetters.popLast() {
            self.userData.nextAnswerLetter.append(pop)
        }
        self.answerLetter = self.userData.nextAnswerLetter.popLast()
        self.submitted = false
    }
    
    func addIncorrectAnswer () {
        if let answer = self.answerLetter{
            self.userData.incorrectlyAnsweredLetters.append(answer)
        }
    }
    
    func setNextAnswer () {
        if let pop = self.userData.unQuestionedLetters.popLast(){
            self.userData.nextAnswerLetter.append(pop)
        }
    }
    
    func unAnswered() -> Int {
        return self.userData.unQuestionedLetters.count
        + (self.userData.unQuestionedLetters.count == 0 ?
            (self.submitted ?
                0 : 1)
            : 1)
    }
    
    func completedRate () -> Double {
        let completed = letters.count - self.userData.incorrectlyAnsweredLetters.count - self.unAnswered()
        let rate = Double(completed) / Double(letters.count)
        let percent = rate * 100.0
        return percent
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            /*letters: lettersData[0].letters,
            pickers: lettersData[0].letters,*/
            letters: lettersData[1].letters,
            pickers: lettersData[1].pickers!,
            title: "何かタイトル"
        )
    }
}
