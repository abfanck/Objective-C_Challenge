//
//  SwiftViewController.swift
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 20/03/20.
//

import UIKit

class SwiftViewController: UIViewController {

    var networking: Networking?
    var movies: [Movie]?
    var genres: [Genre]?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networking = Networking()

        networking?.fetchMovie(POPULAR, completionHandler: { [weak self] (array) in
            guard let self = self else {return}

            self.movies = array as? [Movie]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })

        tableView.delegate = self
        tableView.dataSource = self
        print("a")
    }
}

extension SwiftViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesTableViewCell
        
        let currentMovie = movies?[indexPath.row]
        
        cell.titleLabel?.text = currentMovie?.title
        cell.overviewLabel?.text = currentMovie?.overview
        cell.voteAverageLabel?.text = currentMovie?.voteAverage .stringValue
        cell.posterImage?.image = UIImage(data: currentMovie?.imageData ?? Data())
        
        return cell
    }
    
    
}
