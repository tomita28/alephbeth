//
//  Data.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/02.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Helpers for loading images and data.
*/

import UIKit
import SwiftUI
import CoreLocation

//let letterData: [Letters.Letter] = load("letterData.json")
let lettersData: [Letters] = load("letterData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}



struct Data_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
