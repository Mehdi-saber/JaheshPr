//
//  Data.swift
//  JaheshPr
//
//  Created by mehdi sabermahani on 5/5/17.
//  Copyright © 2017 test1000. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class MyData: Mappable {
    var movies: [Movie]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        movies  <-  map["data"]
    }
}

class Movie: Mappable {
    var id: String?
    var title: String?
    var poster: URL?
    var year: String?
    var country: String?
    var imdb_rating: String?
    var genres: String?
    var images: [URL]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id      <-  map["id"]
        title   <-  map["title"]
        var posterStr:String!
        posterStr <- map["poster"]
        poster = URL(string:posterStr)
        year    <-  map["year"]
        country <-  map["country"]
        var genresStr:[String]!
        genresStr  <-  map["genres"]
        genres = ""
        for gStr in genresStr{
            genres!+=gStr
            if !(genresStr[genresStr.count-1]==gStr){
                genres!+=" , "
            }
        }
        imdb_rating  <-  map["imdb_rating"]
        var imageAr = [String]()
        imageAr <- map["images"]
        images=[URL]()
        for image in imageAr{
            images!.append(URL(string:image)!)
        }
    }
}
