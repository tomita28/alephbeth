//
//  SettingView.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/06/03.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    @Binding var showSheetView: Bool
    @EnvironmentObject var userData: UserData
    //@ObservedObject var userData: UserData

    //@State var selecetion = TransliterationMode.HebrewAcademy2006

    var body: some View {
        NavigationView {
            Form {
                Picker(
                    //selection: $selecetion,
                    selection: $userData.transliterationMode,
                label: Text("ラテン文字転写の方法"))
                {
                    ForEach(
                    TransliterationMode
                        .allCases
                        .filter{switch $0 {
                            case TransliterationMode.Common: return false
                            default: return true
                            }}
                    , id: \.self) {
                        Text($0.rawValue).tag($0)
                    }
                }
            }
            .navigationBarTitle(Text("設定"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    print("Dismissing sheet view...")
                    self.showSheetView = false
                })
                {
                    Text ("完了")
                }
            )
        }
    }
}
 

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(showSheetView: .constant(true))
            //, userData: UserData())
        .environmentObject(UserData())
    }
}
