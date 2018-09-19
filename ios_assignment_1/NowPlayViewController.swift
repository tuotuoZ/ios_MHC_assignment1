//
//  NowPlayViewController.swift
//  ios_assignment_1
//
//  Created by Tony Zhang on 9/18/18.
//  Copyright © 2018 Tony. All rights reserved.
//

import UIKit
import AlamofireImage
import PKHUD


class NowPlayViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var refreshIndicator: UIActivityIndicatorView!
    var movies: [[String :Any]] = []
    var refreshControl: UIRefreshControl!
    
    func fetchMovies(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=d1b54029fde250059112859ad802d27d")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This is will run when the network request returns
            if let error = error{
                print(error.localizedDescription)
            }else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.refreshIndicator.stopAnimating()


            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(NowPlayViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.dataSource = self
        tableView.insertSubview(refreshControl, at: 0)
        fetchMovies()
       
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        refreshIndicator.startAnimating()
        fetchMovies()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURLString + posterPathString)!
        cell.posterImage.af_setImage(withURL: posterURL)
        
        return cell
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
