//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

         navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                //        let text = "⚡️FlashChat"
        titleLabel.text = K.appName

        
        
//        //animation using loop should be replace with cocoa pod
//        titleLabel.text = ""
//        var charIndex = 0.0
//        let text = "⚡️FlashChat"
//        for letter in text {
//            print("-")
//            print(0.1 * charIndex)
//            print(letter)
//
//            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
//                self.titleLabel.text?.append(letter)
//            }
//        charIndex += 1
//        }
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        
    }
    @IBAction func loginPress(_ sender: UIButton) {
           
    }
}
