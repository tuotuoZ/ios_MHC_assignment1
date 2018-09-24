//
//  DetailViewController.swift
//  ios_assignment_1
//
//  Created by tuotuo on 2018/9/23.
//  Copyright © 2018年 Tony. All rights reserved.
//

import UIKit

enum jsonKeys {
    static let title = "title"
    static let backDropPath = "backdrop_path"
    static let posterPath = "poster_path"
}
class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie{
            titileLabel.text = movie[jsonKeys.title] as? String
            releaseDataLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            let backDropPathString = movie[jsonKeys.backDropPath] as! String
            let posterPathString = movie[jsonKeys.posterPath] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backDropUrl = URL(string: baseURLString + backDropPathString)!
            backDropImageView.af_setImage(withURL: backDropUrl)
            let posterUrl = URL(string: baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterUrl)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
