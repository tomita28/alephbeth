//
//  LetterDescriptionsView.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/04.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

struct LetterList: View {
    var letters: [Letter]
    
    var body: some View {
        List(letters, id: \.id){letter in
            NavigationLink(destination: LetterDescription(letter: letter)){
                LetterRow(letter: letter)
            }
        }
    }
}


struct LetterList_Previews: PreviewProvider {
    static var previews: some View {
        LetterList(letters: letterData)
    }
}
