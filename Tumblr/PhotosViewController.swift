//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Jose Patino on 1/28/20.
//  Copyright © 2020 Jose Patino. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate
{
    var posts: [[String: Any]] = []

    
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
           if let error = error
           {
              print(error.localizedDescription)
           } else if let data = data,
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
           {
              print(dataDictionary)
            let responseDictionary = dataDictionary["response"] as! [String: Any]
            self.posts = responseDictionary["posts"] as! [[String: Any]]
            
              // TODO: Get the posts and store in posts property

            self.postsTableView.reloadData()
          }
        }
        task.resume()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! photoCell
        
        let post = posts[indexPath.row]
        
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            cell.photoView.af_setImage(withURL: url!)

        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoDetailsViewController
        
        let cell = sender as! photoCell
        let indexPath = postsTableView.indexPath(for: cell)!
        
        vc.post = posts[indexPath.row]
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postsTableView.deselectRow(at: indexPath, animated: true)
    }

}
