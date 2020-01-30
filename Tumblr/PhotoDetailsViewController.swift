//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by Jose Patino on 1/29/20.
//  Copyright © 2020 Jose Patino. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    

    @IBOutlet weak var postImage: UIImageView!
    
    var post = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let photos = post["photos"] as? [[String: Any]]
        {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            self.postImage.af_setImage(withURL: url!)
        }
    }

}
