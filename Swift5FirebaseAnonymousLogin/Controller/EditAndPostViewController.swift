//
//  EditAndPostViewController.swift
//  Swift5FirebaseAnonymousLogin
//
//  Created by ryota on 2020/05/07.
//  Copyright © 2020 Honda Ryota. All rights reserved.
//

import UIKit
import Firebase

class EditAndPostViewController: UIViewController {

    
    var passedImage = UIImage()
    
    var userName = String()
    var userImageString = String()
    var userImageData = Data()
    var userImage = UIImage()
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var commentTextFiled: UITextView!
    
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
    
    // 送信ボタン
    @IBAction func postAction(_ sender: Any) {
        
        let timeLineDB = Database.database().reference().child("timeLine").childByAutoId()
        
        
        let key = timeLineDB.child("Users").childByAutoId().key
        let key2 = timeLineDB.child("Contents").childByAutoId().key
        
        // ストーレージのURL取得
        let storage = Storage.storage().reference(forURL: "")
        // ストレージからURLを取得する変数
        let imageRef = storage.child("Users").child("\(String(describing: key!)).jpg")
        let imageRef2 = storage.child("Contents").child("\(String(describing: key2!)).jpg")
        
        var userProfileImageData : Data = Data()
        var contentImageData : Data = Data()
        
        
        if userProfileImageView.image != nil {
            
            userProfileImageData = (userProfileImageView.image?.jpegData(compressionQuality:001))!
        }
        
        
        if contentImageView.image != nil {
                   
            contentImageData = (contentImageView.image?.jpegData(compressionQuality:001))!
        }
        
        // ストレージに値を渡す
        let uploadTask = imageRef.putData(userProfileImageData, metadata: nil){
            (metadata, error) in
            
            if error != nil {
                
                print (error)
                return
            }
            
            let uploadTask2 = imageRef2.putData(contentImageData,metadata:nil){
                (metadata,error) in
                
                if error != nil {
                    
                    print (error)
                    return
                }
                
                imageRef.downloadURL { (url, error) in
                    
                    if url != nil {
                        
                        imageRef2.downloadURL { (url2, error) in
                            
                            if url2 != nil {
                                
                                // キーバリュー型で送信するものを準備する( ディクショナリー型)
                                let timeLineInfo = ["userName":self.userName as Any,"userProfileImage":url?.absoluteString as Any,"contents":url2?.absoluteString as Any,"comment":self.commentTextFiled.text as Any,"postData":ServerValue.timestamp()] as [String:Any]
                                
                                // サーバーに全て送信
                                timeLineDB.updateChildValues(timeLineInfo)
                                
                                // 戻る処理
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
            }
        }
        
        uploadTask.resume()
        self.dismiss(animated: true, completion: nil)
    }
    


    
    
    

    
    
    
}
