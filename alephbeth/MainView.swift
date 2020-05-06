//
//  MainView.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/04.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView{
            List{
                HStack{
                    Spacer()
                    Text("メニューを選んでね")
                    .fontWeight(.thin)
                }
                NavigationLink(destination: ContentView()) {
                    Text("ヘブライ文字クイズ")
                }
                NavigationLink(destination: LetterList(letters: letterData)) {
                    Text("ヘブライ文字を覚える")
                }
            }
            .navigationBarTitle(Text("ヘブライ文字暗記"))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self){ deviceName in
            MainView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
