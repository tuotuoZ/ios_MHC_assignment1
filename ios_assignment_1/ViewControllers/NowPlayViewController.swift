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
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(NowPlayViewController.pullToRefresh(_:)), for: .valueChanged)
        tableView.dataSource = self
        tableView.insertSubview(refreshControl, at: 0)
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func pullToRefresh(_ refreshControl: UIRefreshControl) {
        MovieApiManager().nowPlayingMovies { (movies, error) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            }
        }
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
        cell.movie = movie
        return cell
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
}
