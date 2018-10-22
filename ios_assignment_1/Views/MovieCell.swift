//
//  MovieCell.swift
//  ios_assignment_1
//
//  Created by Tony Zhang on 9/18/18.
//  Copyright © 2018 Tony. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie! {
        willSet(newMovie){
            posterImage.af_setImage(withURL: newMovie.posterURL!)
            overviewLabel.text = newMovie.overview
            titleLabel.text = newMovie.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
