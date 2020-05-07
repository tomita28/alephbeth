//
//  LetterExplanationsView.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/04.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

struct LetterList: View {
    var letters: [Letters.Letter]
    var pickers: [Pickable]?
    var title: String
    
    var body: some View {
        List(letters, id: \.id){letter in
            NavigationLink(destination: LetterExplanation(
                letter: letter,
                letters: self.letters,
                pickers: self.pickers ?? self.letters
            )){
                LetterRow(letter: letter)
            }
        }.navigationBarTitle(Text(self.title), displayMode: .inline)
    }
}


struct LetterList_Previews: PreviewProvider {
    static var previews: some View {
        LetterList(
            letters: lettersData[0].letters,
            title: "ヘブライ文字を覚える"
        )
    }
}
