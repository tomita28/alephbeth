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
    @State var answerNum = 0
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                Text(answerLetter().script)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.blue))
                Text("この文字の名前は？")
                    .font(.subheadline)
                Picker(selection: $selection, label: Text("")) {
                    ForEach(0..<letters.count){ num in
                        Text(self.letters[num].name)
                    }
                }
                .labelsHidden()

                HStack{
                    
                    Button(action: {
                        self.isCorrect = (self.letters[self.selection].id == self.answerNum)
                        if(!self.isCorrect && !self.submitted){
                            self.addIncorrectAnswer()
                        }
                        self.submitted = true

                    }) {
                        Text("回答")
                    }
                    
                    Spacer()
                        .frame(width: 80.0)
                    
                    if(self.userData.unQuestionedNums.count > 0){
                        Button(action: {
                            if(!self.submitted){
                                self.addIncorrectAnswer()
                            }
                            self.submitted = false
                            self.answerNum = self.userData.unQuestionedNums.removeLast()
                            self.isCorrect = false
                        }) {
                            Text("次へ")
                        }
                    }else{
                        Text("もうないよ")
                    }
                }
                Spacer()
                if(self.userData.unQuestionedNums.count > 0){
                    Text("あと" + String(self.userData.unQuestionedNums.count) + "問あるよ")
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
                        Text(self.letters[answerNum].name)
                        .bold()
                    }
                }
                
                Spacer()
                
                HStack{
                    NavigationLink(destination: ResultView(userData: userData, percent: userData.completedRate())) {
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
            
        }
        .padding()
    .onAppear(perform: resetQuetions)
    }
    
    func answerLetter () -> Letter {
        self.letters[self.answerNum]
    }
    
    func resetQuetions () {
        self.userData.incorrectlyAnsweredLetters = []
        self.userData.unQuestionedNums = Array(0...self.letters.count-1)
        self.userData.unQuestionedNums.shuffle()
        self.answerNum = self.userData.unQuestionedNums.removeLast()
        self.submitted = false
    }
    
    func addIncorrectAnswer () {
        self.userData.incorrectlyAnsweredLetters.append(self.letters[self.answerNum])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
            )

            Spacer()
            Text("間違えた文字たち")
            List{
                ForEach(userData.incorrectlyAnsweredLetters,id: \.self){letter in
                    HStack{
                        Text(letter.script)
                            .font(.largeTitle)
                        Spacer()
                        Text(letter.name)
                    }
                }
            }
        }
    }
}
