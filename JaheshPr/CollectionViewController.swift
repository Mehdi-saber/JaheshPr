//
//  GalleryViewController.swift
//  ARToolKit5iOS
//
//  Created by mehdi sabermahani on 4/22/17.
//
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class CollectionViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "MyCell"
    
    var movies=[Movie]()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        collectionView.collectionViewLayout = layout
        
        getMovieList() 
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()        // Dispose of any resources that can be recreated.
    }
    
    func getMovieList() {
        let URL = "http://moviesapi.ir/api/v1/movies?page=0"
        Alamofire.request(URL).responseObject { (response: DataResponse<MyData>) in
            self.movies = response.result.value!.movies!
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue"{
            let cell=sender as! MyCollectionViewCell
            let dest=segue.destination as! DetailViewController
            dest.movie=movies[self.collectionView.indexPath(for: cell)!.row]
        }
    }
    
    // MARK: -
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        cell.configure(movie: movies[indexPath.row])
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    // MARK: -
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = storyboard!.instantiateViewController(withIdentifier: "ShowViewController")
//        (vc as! ShowViewController).passValues["imageUrls"]=imageUrls
//        (vc as! ShowViewController).passValues["index"]=indexPath.row
//        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: -
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width/2)-20
        return CGSize(width: width   , height: width*1.5)
    }    
}
