//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Memo on 10/4/18.
//  Copyright © 2018 Membriux. All rights reserved.
// Marks Walkthought tis morning

import Foundation
import UIKit
import AlamofireImage

class PhotosViewController: UIViewController {

    
    
    // Create Outlet of tableview and the posts variable

    @IBOutlet weak var photoTableView: UITableView!
    
    var posts: [[String: Any]] = []  //will contain all the data from the api
    override func viewDidLoad() {
        super.viewDidLoad()
        photoTableView.delegate = self
        photoTableView.dataSource = self
        getPosts()
          
      }
    
    // –––––– TODO: Get posts from APIs.swift
    // what we are going here is calling the api function

    func getPosts() {
        API.getPosts() {(posts) in // receiving the post
            if let posts = posts {  //error provention  like if post != nill guarfing from crashing
                self.posts = posts // if not empty we are setting the post variable to the post from the api call
                self.photoTableView.reloadData() // reload tavle view to load the immages
                
            }
        }
    }
}

extension PhotosViewController: UITableViewDelegate, UITableViewDataSource{
    //how many rows in the cells to have on the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    // what content is going to be displaied 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell") as! PhotosTableViewCell
        //make sure the identifer is the same as storyboard identifer
        //now we need to tell what immage
        let post = posts[indexPath.row]
        // get url immage from the api
        let url = API.getImageURL(post: post)
        //place immage into cell
        cell.photoImage.af_setImage(withURL: url)
        return cell
    }
    
    
}

