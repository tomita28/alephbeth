//
//  Banner.swift
//  alephbeth
//
//  Created by 御堂 大嗣 on 2020/05/08.
//  Copyright © 2020 御堂 大嗣. All rights reserved.
//

import SwiftUI
import GoogleMobileAds
import UIKit

final private class BannerVC: UIViewControllerRepresentable  {
    
    
    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)
        
        //test用bannerID
        let bannerID = "ca-app-pub-3940256099942544/2934735716"
        //本番用bannerID: first_banner
        //let bannerID = "ca-app-pub-3865271057827792/9425055269"

        let viewController = UIViewController()
        view.adUnitID = bannerID
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct Banner:View{
    var body: some View{
        HStack{
            Spacer()
            BannerVC().frame(width: 320, height: 50, alignment: .center)
            Spacer()
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner()
    }
}
