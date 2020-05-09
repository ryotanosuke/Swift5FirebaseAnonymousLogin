//
//  EditAndPostViewController.swift
//  Swift5FirebaseAnonymousLogin
//
//  Created by ryota on 2020/05/07.
//  Copyright © 2020 Honda Ryota. All rights reserved.
//

import UIKit
import Firebase

class EditAndPostViewController: UIViewController , UITextViewDelegate {

    
    var passedImage = UIImage()
    
    var userName = String()
    var userImageString = String()
    var userImageData = Data()
    var userImage = UIImage()
    
    let screenSize = UIScreen.main.bounds.size
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var commentTextFiled: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        commentTextFiled.delegate = self
        
        // キーボドのスライド
        NotificationCenter.default.addObserver(self, selector: #selector(EditAndPostViewController.keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EditAndPostViewController.keyboardWillShow(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)

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
    
    
    
    @objc func keyboardWillShow(_ notification:NSNotification){
        
        //notificationの情報を元に高さを決める
        //cgRectValueは機種ごとの物差しの値
        let keyboardHeight = ((notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as Any) as AnyObject).cgRectValue.height
        
        //frame.origin.yはき開いたキーボードの左上開始位置の座標
        commentTextFiled.frame.origin.y = screenSize.height - keyboardHeight - commentTextFiled.frame.height
        
        sendButton.frame.origin.y  = screenSize.height - keyboardHeight - sendButton.frame.height
        
    }
    
    
    
    // キーボートの閉じる時の処理
    @objc func keyboardWillHide(_ notification:NSNotification){
        
        commentTextFiled.frame.origin.y = screenSize.height - commentTextFiled.frame.height
        
        
        // キーボードが下がる時間をdurationとしてとる
        guard let rect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else{return}
        
        // キーボードが下がる時間をアニメーションさせる
        UIView.animate(withDuration: duration){
            
            let transform = CGAffineTransform(translationX: 0, y: 0)
            
            self.view.transform = transform
        }
    }
    
    
    
    // キーボードをタッチで閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        commentTextFiled.resignFirstResponder()
        
    }
    
    
    
    // ritunでキーボードを閉じる
    // textFieldでどのキーボードか検知
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
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
        let storage = Storage.storage().reference(forURL: "gs://swift5firebaseanonymousl-90d14.appspot.com")
        
        // ストレージからURLを取得する変数
        let imageRef = storage.child("Users").child("\(String(describing: key!)).jpg")
        let imageRef2 = storage.child("Contents").child("\(String(describing: key2!)).jpg")
        
        var userProfileImageData : Data = Data()
        var contentImageData : Data = Data()
        
        
        if userProfileImageView.image != nil {
            
            userProfileImageData = (userProfileImageView.image?.jpegData(compressionQuality:0.01))!
        }
        
        
        if contentImageView.image != nil {
                   
            contentImageData = (contentImageView.image?.jpegData(compressionQuality:0.01))!
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
                                let timeLineInfo = ["userName":self.userName as Any,"userProfileImage":url?.absoluteString as Any,"contents":url2?.absoluteString as Any,"comment":self.commentTextFiled.text as Any,"postDate":ServerValue.timestamp()] as [String:Any]
                                
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
