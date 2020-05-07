//
//  InputViewController.swift
//  Swift5FirebaseAnonymousLogin
//
//  Created by ryota on 2020/05/06.
//  Copyright © 2020 Honda Ryota. All rights reserved.
//

import UIKit

class InputViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    
    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var userNameTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImageView.layer.cornerRadius = 30.0
    }
    
    
    
    //　表示されるたびに何回も発動
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // ナビゲーションバーを削除
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // 決定ボタン
    @IBAction func done(_ sender: Any) {
        
        // ユーザー名をアプリ内に保存
        UserDefaults.standard.set(userNameTextField.text, forKey: "userName")
        
        // アイコンもアプリ内に保存
        // データ圧縮
        let data = logoImageView.image?.jpegData(compressionQuality: 0.1)
        
        UserDefaults.standard.set(data, forKey: "userImage")
        
        // 画面遷移　（pushVIew）
        let nextVC = self.storyboard?.instantiateViewController(identifier: "nextVC") as! NexyViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    // その他の画面をタッチした場合
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // キーボドの非表示
        userNameTextField.resignFirstResponder()
    }
    


    // イメージビューがタップされる時に呼ばれる
    @IBAction func imageViewTap(_ sender: Any) {
        
        let generator = UINotificationFeedbackGenerator()
        
        generator.notificationOccurred(.success)
        
        // カメラ　or アルバムを選択させる
        showAlert()
        
    }
    
    
    // カメラ立ち上げ
    func doCamera() {
        
        // ソースタイプの選択
        let sourceType : UIImagePickerController.SourceType = .camera
        
        // カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    
    
    // カメラ立ち上げ
    func doAlbum() {
        
        // ソースタイプの選択
        let sourceType : UIImagePickerController.SourceType = .photoLibrary
        
        // カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
        
     
    // アルバムや撮影した画像のデータを取得(デリゲート)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[.originalImage] as? UIImage != nil{
            
            // infoのデータを取得
            let selectedImage = info[.originalImage] as! UIImage
            
            // データを圧縮し、デファルト設定
            UserDefaults.standard.set(selectedImage.jpegData(compressionQuality: 0.1), forKey: "userImage")
            
            logoImageView.image = selectedImage
            
            // 閉じる処理
            picker.dismiss(animated: true, completion: nil)
        }
    }
        
        
        // キャンセルが押された時の処理
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
         
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    // アラート
    func showAlert(){
        
        let alertController = UIAlertController(title: "選択", message: "どちらを選択しますか？", preferredStyle: .actionSheet)
        
        let acion1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            
            self.doCamera()
        }
        
        let acion2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            
            self.doAlbum()
        }
        
        let acion3 = UIAlertAction(title: "キャンセル", style: .default)
            
        alertController.addAction(acion1)
        alertController.addAction(acion2)
        alertController.addAction(acion3)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    
    
    
        
        
        
        
        

}
