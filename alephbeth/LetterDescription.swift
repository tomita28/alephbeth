//
//  LetterDescription.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/04.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

struct LetterDescription: View {
    var letter: Letter
    var letters: [Letter] = letterData
    var body: some View {
        ScrollView{
            Text("いいから覚えるんだ")
            Text("左右の横線（アンダースコア）は文字の高さの基準にしましょう。")
                .padding()
            self.displayFont(text: Text("_" + letter.script + "_"), name: "活字体")
            if(!letter.dagesh){
                self.displayFont(text: Text("_" + letter.script + "_")
                    .font(.custom("KtavYadCLM-BoldItalic", size: 150))
                , name:"筆記体")

            }
            
            HStack{
                Text("読み方:")
                Text(letter.name).font(.system(.largeTitle))
            }
            if(letter.dagesh){
                HStack{
                    Text("ダゲッシュ（真ん中の点）あり")
                }
                HStack{
                    Text("元の字:")
                    Text(findLetterById(id: letter.original).script)
                        .font(.largeTitle)
                    
                }
            }
            Spacer()
            Text("解説:")
            Text(letter.description).padding()
        }
        .navigationBarTitle(Text(letter.script), displayMode: .inline)
    }
    
    func findLetterById(id: Int) -> Letter{
        let targetId = letters.enumerated().filter({ $0.element.id == id}).map({ $0.offset })
        return self.letters[targetId[0]]
    }
    
    func displayFont (text: Text, name: String) -> some View {
        return VStack{
            HStack{
                text.font(.system(size: 150)).padding()
            }
            Text(name).padding(.bottom)
        }
    }
}

struct LetterDescription_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            LetterDescription(letter: letterData[0])
            LetterDescription(letter: letterData[2])
            LetterDescription(letter: letterData[3])
            LetterDescription(letter: letterData[17])

        }
    }
}
