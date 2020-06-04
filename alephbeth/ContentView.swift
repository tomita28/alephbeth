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
    var questionedLetters: [Letters.Letter]?
    let pickers: [Pickable]
    let title: String
    
    @ObservedObject var quizData = QuizData()
    @EnvironmentObject var userData: UserData
    
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
                ForEach(pickers.filter{
                    let contains = $0.name.keys.contains
                    return contains(TransliterationMode.Common.rawValue) || contains(userData.transliterationMode.rawValue)
                }, id: \.id){ picker in
                    Text(
                        picker.name[self.userData.transliterationMode.rawValue]
                            ?? picker.name[TransliterationMode.Common.rawValue]!
                    ).tag(picker.id)
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
            }
            Spacer()
            if(self.unAnswered() > 0){
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
                    quizData: quizData,
                    withUnderScores: self.withUnderScores,
                    questionAmount: self.questionedLetters?.count,
                    letters: letters,
                    pickers: pickers,
                    percent: self.completedRate())
                    .environmentObject(userData)
                ) {
                    Text("結果を見る")
                }
                Spacer()
                Button(action: {self.resetQuetions()})
                {
                    Text("最初から")
                }
                Spacer()
                //まだ残りの問題がある時
                if(self.unAnswered() > 1 && !self.submitted
                    || self.unAnswered() > 0 && self.submitted){
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
                        self.answerLetter = self.quizData.nextAnswerLetter.popLast()
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
        let name = correctPicker?.name
        return  name?[self.userData.transliterationMode.rawValue] ?? name![TransliterationMode.Common.rawValue]!
    }
    func answerLetterScript () -> String {
        self.answerLetter.map{$0.script} ?? "答えがないよ"
    }
    
    func resetQuetions () {
        self.quizData.incorrectlyAnsweredLetters = []
        self.quizData.nextAnswerLetter = []
        self.quizData.unQuestionedLetters = (questionedLetters ?? letters)
            .filter{
                let contains = $0.name.keys.contains
                return contains(TransliterationMode.Common.rawValue)
                || contains(userData.transliterationMode.rawValue)
                
        }
        self.quizData.unQuestionedLetters.shuffle()
        if let pop = self.quizData.unQuestionedLetters.popLast() {
            self.quizData.nextAnswerLetter.append(pop)
        }
        self.answerLetter = self.quizData.nextAnswerLetter.popLast()
        self.submitted = false
    }
    
    func addIncorrectAnswer () {
        if let answer = self.answerLetter{
            self.quizData.incorrectlyAnsweredLetters.append(answer)
        }
    }
    
    func setNextAnswer () {
        if let pop = self.quizData.unQuestionedLetters.popLast(){
            self.quizData.nextAnswerLetter.append(pop)
        }
    }
    
    func unAnswered() -> Int {
        return self.quizData.unQuestionedLetters.count
            + self.quizData.nextAnswerLetter.count
            + (self.submitted ? 0 : 1)
           
    }
    
    func completedRate () -> Double {
        let allLetters = questionedLetters ?? letters
        let completed = allLetters.count - self.quizData.incorrectlyAnsweredLetters.count - self.unAnswered()
        let rate = Double(completed) / Double(allLetters.count)
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
            questionedLetters: lettersData[1].letters.filter{$0.id < 7},
            pickers: lettersData[1].pickers!,
            title: "何かタイトル"
        )
    }
}
