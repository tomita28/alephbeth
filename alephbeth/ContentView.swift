//
//  ContentView.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/01.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let letters: [Letter] = letterData

    @ObservedObject var userData = UserData()
    
    @State var selection = 0
    @State var submitted = false
    @State var isCorrect = false
    @State var answerNum: Int? = nil
    
    var body: some View {
        VStack {
            Text(answerLetterScript())
                .font(.largeTitle)
            Text("この文字の名前は？")
                .font(.subheadline)
            Picker(selection: $selection, label: Text("")) {
                ForEach(0..<letters.count){ num in
                    Text(self.letters[num].name)
                }
            }
            .labelsHidden()

            HStack{
                //まだこの問題に対して回答していない時
                if(!self.submitted){
                    //回答ボタン有効
                    Button(action: {
                        //正誤をチェック
                        self.isCorrect = (self.letters[self.selection].id == self.answerNum)
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
                
                
                //まだ残りの問題がある時
                if(self.userData.unQuestionedNums.count > 0){
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
                        self.answerNum = self.userData.nextAnswerNum.popLast()
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
            Spacer()
            if(self.userData.unQuestionedNums.count >= 0){
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
                NavigationLink(destination: ResultView(userData: userData, percent: self.completedRate())) {
                    Text("結果を見る")
                }
                Spacer()
                Button(action: {self.resetQuetions()})
                {
                    Text("最初から")
                }
            }
        }
        .padding()
        .onAppear(perform: resetQuetions)
        .navigationBarTitle("ヘブライ文字クイズ", displayMode: .inline)
    }
    
    func answerLetter () -> Letter? {
        self.answerNum.map{self.letters[$0]}
    }
    func answerLetterName () -> String {
        self.answerLetter().map{$0.name} ?? "答えがないよ"
    }
    func answerLetterScript () -> String {
        self.answerLetter().map{$0.script} ?? "答えがないよ"
    }
    
    func resetQuetions () {
        self.userData.incorrectlyAnsweredLetters = []
        self.userData.unQuestionedNums = Array(0...self.letters.count-1)
        self.userData.unQuestionedNums.shuffle()
        if let pop = self.userData.unQuestionedNums.popLast() {
            self.userData.nextAnswerNum.append(pop)
        }
        self.answerNum = self.userData.nextAnswerNum.popLast()
        self.submitted = false
    }
    
    func addIncorrectAnswer () {
        if let answer = self.answerLetter(){
            self.userData.incorrectlyAnsweredLetters.append(answer)
        }
    }
    
    func setNextAnswer () {
        if let pop = self.userData.unQuestionedNums.popLast(){
            self.userData.nextAnswerNum.append(pop)
        }
    }
    
    func unAnswered() -> Int {
        return self.userData.unQuestionedNums.count
        + (self.userData.unQuestionedNums.count == 0 ?
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
        ContentView()
    }
}
