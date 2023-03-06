//
//  DetailViewController.swift
//  UNIT3
//
//  Created by Iyinoluwa Tugbobo on 3/6/23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    
    var movie: Movie? = nil
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var overview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = movie?.title
        overview.text = movie?.overview
        let url = movie?.poster_path
        Nuke.loadImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + url!)!, into: poster)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
