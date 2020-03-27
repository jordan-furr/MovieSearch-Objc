//
//  JEFMovieTableViewController.swift
//  MovieSearch-Objc
//
//  Created by Jordan Furr on 3/27/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class JEFMovieTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var movieSearch: UISearchBar!
    var movies: [JEFMovie] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Search"
        movieSearch.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? JEFMovieTableViewCell else {return UITableViewCell()}

        let movie = movies[indexPath.row]
        cell.titlelabel.text = movie.title
        cell.ratinglabel.text = "Rating: \(movie.rating)"
        cell.descriptionlabel.text = movie.overview
        cell.descriptionlabel.isEditable = false
        
        JEFMovieController.fetchPoster(movie) { (image) in
            DispatchQueue.main.async {
                if (image != nil){
                    cell.posterImage.image = image
                }
                else {
                    cell.posterImage.image = #imageLiteral(resourceName: "download-1")
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        JEFMovieController.fetchMovies(searchTerm) { (movies) in
            DispatchQueue.main.async {
                self.movies = movies
                self.tableView.reloadData()
            }
        }
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
