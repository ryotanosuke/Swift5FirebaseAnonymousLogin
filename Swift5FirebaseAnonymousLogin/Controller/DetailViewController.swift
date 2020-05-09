//
//  DetailViewController.swift
//  Swift5FirebaseAnonymousLogin
//
//  Created by ryota on 2020/05/07.
//  Copyright © 2020 Honda Ryota. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    
    var userName = String()
    var contentImage = String()
    var date = String()
    var profileImage = String()
    var comment = String()
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var contentsImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.layer.cornerRadius = 20.0
        
        // URL型に変換して反映
        profileImageView.sd_setImage(with: URL(string:profileImage), completed: nil)
        
        userNameLabel.text = userName
                
        dateLabel.text = date
        
        // URL型に変換して反映
        contentsImageView.sd_setImage(with:URL(string: contentImage),completed:nil)
        
        commentLabel.text = comment

    }
    

    @IBAction func shareAction(_ sender: Any) {
        
        let items = [contentsImageView.image] as Any
        
        let acView = UIActivityViewController(activityItems:[items], applicationActivities:nil)
        
        present(acView, animated:  true, completion: nil)
    }
    
    
    
    

}
