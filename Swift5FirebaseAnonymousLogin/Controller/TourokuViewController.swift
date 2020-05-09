//
//  TourokuViewController.swift
//  Swift5FirebaseAnonymousLogin
//
//  Created by ryota on 2020/05/06.
//  Copyright © 2020 Honda Ryota. All rights reserved.
//

import UIKit
import Firebase

class TourokuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 新規登録ボタン
    @IBAction func login(_ sender: Any) {
        
        // 匿名認証
        Auth.auth().signInAnonymously { (authResult, error) in
            
            let user = authResult?.user
            print(user)
            
            // セグエじゃない画面遷移
            let inputVC = self.storyboard?.instantiateViewController(identifier: "inputVC") as! InputViewController
            
            // showの遷移を可能にする
            self.navigationController?.pushViewController(inputVC, animated: true)
            
        }
        
        
        
    }
    


}
