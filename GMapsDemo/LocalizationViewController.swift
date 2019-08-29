//
//  LocalizationViewController.swift
//  GMapsDemo
//
//  Created by 2130 on 8/29/19.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import UIKit

class LocalizationViewController: UIViewController {
    
    @IBOutlet weak var helloLbl: UILabel!
    @IBOutlet weak var switchLan: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func switchLangAction(_ sender: UIButton) {
        if L102Language.currentAppleLanguage() == "en" {
            L102Language.setAppleLAnguageTo(lang: "ar")
        } else {
            L102Language.setAppleLAnguageTo(lang: "en")
        }
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootnav")
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: .transitionFlipFromLeft, animations: { () -> Void in
        }) { (finished) -> Void in
        }

    }
    
}
