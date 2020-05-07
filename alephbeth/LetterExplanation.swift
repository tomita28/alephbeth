//
//  LetterExplanation.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/04.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

struct LetterExplanation: View {
    var withUnderScores: Bool?
    var letter: Letters.Letter
    var letters: [Letters.Letter]
    var pickers: [Pickable]
    var body: some View {
        ScrollView{
            Text("いいから覚えるんだ")
                .padding()
            if(withUnderScores ?? true){
                Text("左右の横線（アンダースコア）を文字の高さの基準にしてください。")
                    .padding()
            }
            self.displayFont(text: Text(self.textWithUnderScores(string: letter.script)), name: "活字体")
            if(!(letter.dagesh ?? true)){
                self.displayFont(text: Text(self.textWithUnderScores(string: letter.script))
                    .font(.custom("KtavYadCLM-BoldItalic", size: 150))
                , name:"筆記体")

            }
            
            HStack{
                Text("名前:")
                Text(letter.name).font(.system(.largeTitle))
            }
            if(letter.dagesh ?? false){
                HStack{
                    Text("ダゲッシュ（真ん中の点）あり")
                }.padding()
                HStack{
                    Text("元の字:")
                    Text(findLetterById(id: letter.original!).script)
                        .font(.largeTitle)
                    
                }.padding()
            }
            if((letter.answerId) != nil){
                HStack{
                    Text("発音: ")
                    Text(pickers.filter{$0.id == letter.answerId!}.first!.name)
                        .font(.largeTitle)
                }.padding()
            }
            Spacer()
            Text("解説:")
            Text(letter.explanation).padding()
        }
        .navigationBarTitle(Text(letter.script), displayMode: .inline)
    }
    
    func textWithUnderScores(string: String) -> String {
        if (self.withUnderScores ?? true ) {
            return "_" + string + "_"
        }else{
            return string
        }
    }
    
    func findLetterById(id: Int) -> Letters.Letter{
        let targetId = letters.enumerated().filter({ $0.element.id == id}).map({ $0.offset })
        return self.letters[targetId[0]]
    }
    
    func displayFont (text: Text, name: String) -> some View {
        return VStack{
            HStack{
                text.font(.system(size: 150)).padding()
            }
            Text(name).padding(.bottom, 100.0)
        }
    }
}

struct LetterExplanation_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            LetterExplanation(
                letter: lettersData[0].letters[0],
                letters: lettersData[0].letters,
                pickers: lettersData[0].letters
            )
            LetterExplanation(
                letter: lettersData[0].letters[2],
                letters: lettersData[0].letters,
                pickers: lettersData[0].letters
            )
            //LetterExplanation(letter: lettersData[0].letters[2])
            //LetterExplanation(letter: lettersData[0].letters[3])
            //LetterExplanation(letter: lettersData[0].letters[17])
            LetterExplanation(
                letter: lettersData[1].letters[0],
                letters: lettersData[1].letters,
                pickers: lettersData[1].pickers!
            )
        }
    }
}
