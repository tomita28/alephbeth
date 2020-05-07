//
//  LetterRow.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/04.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

struct LetterRow: View {
    var letter: Letters.Letter
    
    var body: some View {
        HStack{
            Text(letter.script)
                .font(.largeTitle)
                .padding(.trailing)
            Text(letter.name)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct LetterRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            LetterRow(letter: lettersData[0].letters[0])
            LetterRow(letter: lettersData[0].letters[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
