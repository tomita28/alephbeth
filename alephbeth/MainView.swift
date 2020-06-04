//
//  MainView.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/04.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var userData: UserData
    @State var showingSetting = false
    
    var body: some View {
        VStack{
            NavigationView{
                List{
                    HStack{
                        Spacer()
                        Text("メニューを選んでね")
                        .fontWeight(.thin)
                    }
                    NavigationLink(destination: ContentView(
                            letters: lettersData[0].letters,
                            pickers: lettersData[0].letters,
                            title: "ヘブライ文字クイズ"
                            ))
                    {
                        Text("ヘブライ文字クイズ")
                    }
                    NavigationLink(destination: ContentView(
                            withUnderScores: false,
                            letters: lettersData[1].letters,
                            pickers: lettersData[1].pickers!,
                            title: "母音記号クイズ"
                        ))
                    {
                        Text("母音記号クイズ")
                    }
                    NavigationLink(destination: LetterList(
                        letters: lettersData[0].letters,
                        title: "ヘブライ文字を覚える"))
                    {
                        Text("ヘブライ文字を覚える")
                    }
                    NavigationLink(destination: LetterList(
                        withUnderScores: false,
                        letters: lettersData[1].letters,
                        pickers: lettersData[1].pickers!,
                        title: "母音記号を覚える"))
                    {
                        Text("母音記号を覚える")
                    }
                }
                .navigationBarTitle(Text("ヘブライ文字暗記"))
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showingSetting.toggle()
                    }) {
                        Image(systemName: "gear").imageScale(.large)
                    }.sheet(isPresented: $showingSetting) {
                        SettingView(
                            showSheetView: self.$showingSetting// userData: self.userData
                        )
                        .environmentObject(self.userData)
                    }
                )
            }
        
            Banner()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([
            "iPhone SE",
            //"iPhone XS Max"
        ], id: \.self){ deviceName in
            MainView()
            .environmentObject(UserData())
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
