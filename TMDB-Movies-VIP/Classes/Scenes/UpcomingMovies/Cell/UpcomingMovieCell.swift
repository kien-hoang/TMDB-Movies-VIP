//
//  UpcomingMovieCell.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 01/01/2023.
//

import UIKit

final class UpcomingMovieCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var averagePointLabel: UILabel!
    @IBOutlet private weak var editButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.cancelImageDownload()
        posterImageView.image = nil
    }
}

// MARK: - IBAction

private extension UpcomingMovieCell {
    @IBAction func editButtonTapped(_ sender: Any) {
        
    }
}

// MARK: - Public

extension UpcomingMovieCell {
    func update(with movie: UpcomingMovieViewModel) {
        idLabel.text = "ID: \(movie.id)"
        nameLabel.text = "Name: \(movie.title)"
        overviewLabel.text = "Overview: \(movie.overview)"
        averagePointLabel.text = "Vote Average: \(movie.voteAverage)"
        posterImageView.setImage(with: URL(string: movie.posterUrl))
    }
}
