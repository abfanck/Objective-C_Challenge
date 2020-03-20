//
//  SwiftViewController.swift
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 20/03/20.
//

import UIKit

class SwiftViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    var networking: Networking?
    var movies: [Movie]?
    var genres: [Genre]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networking = Networking()
        
        print("carregou")

        networking?.fetchMovie(true, completionHandler: { [weak self] (array) in
            guard let self = self else {return}
            
            self.movies = array as? [Movie]
            
            print(self.movies ?? [])
            
            let data = self.networking?.getImageData(self.movies?[0].posterpath ?? "")
            
            DispatchQueue.main.async {
                self.image.image = UIImage(data: data ?? Data())
            }
        })
        
        networking?.fetchMovie(false, completionHandler: { [weak self] (array) in
            guard let self = self else {return}
            
            self.movies = array as? [Movie]
            for movie in self.movies ?? [] {
                print(movie.title)
            }
        })
        
        
    }
}
