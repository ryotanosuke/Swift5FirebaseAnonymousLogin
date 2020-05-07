//
//  EditAndPostViewController.swift
//  Swift5FirebaseAnonymousLogin
//
//  Created by ryota on 2020/05/07.
//  Copyright © 2020 Honda Ryota. All rights reserved.
//

import UIKit

class EditAndPostViewController: UIViewController {

    
    var passedImage = UIImage()
    
    var userName = String()
    var userImageString = String()
    var userImageData = Data()
    var userImage = UIImage()
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // アプリ内に保存されているデータを呼び出して反映していく
        if UserDefaults.standard.object(forKey: "userName") != nil{
            
            userName = UserDefaults.standard.object(forKey: "userName") as! String
        }
        
        if UserDefaults.standard.object(forKey: "userImage") != nil{
            
            userImageData = UserDefaults.standard.object(forKey: "userImage") as! Data
            
            userImage = UIImage(data:userImageData)!
        }
        
        userProfileImageView.image = userImage
        userNameLabel.text = userName
        contentImageView.image = passedImage
    }
    
    
    // ナビゲーションバーを消す
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    @IBAction func postAction(_ sender: Any) {
    }
    
    
    

}
