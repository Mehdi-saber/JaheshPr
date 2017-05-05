//
//  DetailViewController.swift
//  JaheshPr
//
//  Created by mehdi sabermahani on 5/5/17.
//  Copyright © 2017 test1000. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var navBarItem: UINavigationItem!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie:Movie!
    let reuseIdentifier = "DetailImageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        imagesCollectionView.collectionViewLayout = layout
        
        navBarItem.title=movie.title
        
        let placeholderImage = UIImage(named: "PlaceHolderImage")!
        posterImageView.af_setImage(withURL: movie.poster!, placeholderImage: placeholderImage)
        
        var descriptionText =   "Title  :   \(movie.title ?? "Unknown")\n"
        descriptionText     +=  "Year   :   \(movie.year ?? "Unknown")\n"
        descriptionText     +=  "Country:   \(movie.country ?? "Unknown")\n"
        descriptionText     +=  "Generes:   \(movie.genres ?? "Unknown")\n"
        descriptionText     +=  "IMDB   :   \(movie.imdb_rating ?? "Unknown")"
        descriptionTextView.text=descriptionText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToMovies(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // MARK: -
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.images!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DetailCollectionViewCell
        cell.configure(imageURL: movie.images![indexPath.row])
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // MARK: -
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: -
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = (collectionView.frame.size.height)-20
        return CGSize(width: dimension*16/9   , height: dimension)
    }
    
}
