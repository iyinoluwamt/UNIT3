//
//  ViewController.swift
//  UNIT3
//
//  Created by Iyinoluwa Tugbobo on 3/5/23.
//

import UIKit
import Alamofire
import Nuke

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items: [Movie] = []
    let key: String = "32d3d96bbd7c27a2ebe60ebeb83393c9"
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=" + key
        AF.request(url).responseDecodable(of:MovieResponse.self) { (response) in
            guard let films = response.value else { return }
            self.items = films.results
            self.table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.MovieCell", for: indexPath) as! MovieCell
        let movie = items[indexPath.row]
        
        let url = movie.poster_path
        Nuke.loadImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + url)!, into: cell.poster)
        
        cell.title.text = movie.title
        cell.overview.text = movie.overview
        cell.release_date.text = movie.release_date
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = items[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = table.indexPathForSelectedRow
        let index = indexPath?.row
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = items[index!]
    }
}

struct MovieResponse: Decodable {
    var results: [Movie]
}

struct Movie: Decodable {
    var title: String
    var overview: String
    var popularity: Float
    var poster_path: String
    var release_date: String
    var vote_average: Float
    var vote_count: Int
}

