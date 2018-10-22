//
//  Movie.swift
//  ios_assignment_1
//
//  Created by Tony Zhang on 10/21/18.
//  Copyright © 2018 Tony. All rights reserved.
//

import Foundation


class Movie {
    
    var title: String
    var overview: String
    var posterURL: URL?
    var releaseDate: String
    var backdropURL: URL?
    
    // Movie Initializer
    init(dictionary: [String: Any]) {
        // Set the string variables
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
        
        // Set the image variables
        let posterPath = dictionary["poster_path"] as? String ?? "No poster path"
        let backdropPath = dictionary["backdrop_path"] as? String ?? "No backdrop path"
        let baseURL = "https://image.tmdb.org/t/p/w500"
        posterURL = URL(string: baseURL + posterPath)
        backdropURL = URL(string: baseURL + backdropPath)


    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}

