//
//  PostersViewController.swift
//  UNIT3
//
//  Created by Iyinoluwa Tugbobo on 3/6/23.
//

import UIKit
import Alamofire
import Nuke

class PostersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var items: [Movie] = []
    let key: String = "32d3d96bbd7c27a2ebe60ebeb83393c9"

    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=" + key
        AF.request(url).responseDecodable(of:MovieResponse.self) { (response) in
            guard let films = response.value else { return }
            self.items = films.results
            self.movieCollectionView.reloadData()
        }
        
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        let layout = movieCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        let numberOfColumns: CGFloat = 3
        let width = (movieCollectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns
        layout.itemSize = CGSize(width: width, height: width)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        let movie = items[indexPath.item]
        let imageUrl = "https://image.tmdb.org/t/p/original/" + movie.poster_path
        Nuke.loadImage(with: URL(string: imageUrl)!, into: cell.poster)
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        let cell = sender as! UICollectionViewCell
        guard let indexPath = movieCollectionView.indexPath(for: cell) else {return}
        detailViewController.movie = self.items[indexPath.row]
    }
}
