////
////  JSONTMDb.swift
////  MovieInternetDB
////
////  Created by Erick Quintanar on 5/4/17.
////  Copyright © 2017 equintanart. All rights reserved.
////
//
////created with http://guideluxe.com/JsonToSwift
////feedback@GuiDeluxe.com
////@PerryTribolet
////usage: var json:jsonTMDb = jsonTMDb.Populate(data:nsdata)
////where nsdata is an NSData object containing the json string
//
//import Foundation
//
//class Result {
//    var poster_path:String = ""
//    var adult:Bool = false
//    var overview:String = ""
//    var release_date:String = ""
//    var genre_ids:[Int] = []
//    var id:Int = 0
//    var original_title:String = ""
//    var original_language:String = ""
//    var title:String = ""
//    var backdrop_path:String = ""
//    var popularity:Float = 0
//    var vote_count:Int = 0
//    var video:Bool = false
//    var vote_average:Float = 0
//    
//    func Populate(dictionary:NSDictionary) {
//        
//        poster_path = dictionary["poster_path"] as! String
//        adult = dictionary["adult"] as! Bool
//        overview = dictionary["overview"] as! String
//        release_date = dictionary["release_date"] as! String
//        genre_ids = Int.PopulateArray(dictionary["genre_ids"] as! [NSArray])
//        id = dictionary["id"] as! Int
//        original_title = dictionary["original_title"] as! String
//        original_language = dictionary["original_language"] as! String
//        title = dictionary["title"] as! String
//        backdrop_path = dictionary["backdrop_path"] as! String
//        popularity = dictionary["popularity"] as! Float
//        vote_count = dictionary["vote_count"] as! Int
//        video = dictionary["video"] as! Bool
//        vote_average = dictionary["vote_average"] as! Float
//    }
//    
//    class func PopulateArray(array:NSArray) -> [Result] {
//        var result:[Result] = []
//        for item in array {
//            let newItem = Result()
//            newItem.Populate(dictionary: item as! NSDictionary)
//            result.append(newItem)
//        }
//        return result
//    }
//    
//}
//
//class jsonTMDb
//{
//    var page:Int = 0
//    var results:[Result] = []
//    var total_results:Int = 0
//    var total_pages:Int = 0
//    
//    func Populate(dictionary:NSDictionary) {
//        
//        page = dictionary["page"] as! Int
//        results = Result.PopulateArray(array: (dictionary["results"] as? NSArray)!)
//        total_results = dictionary["total_results"] as! Int
//        total_pages = dictionary["total_pages"] as! Int
//    }
//    
//    class func DateFromString(dateString:String) -> NSDate {
//        let dateFormatter = DateFormatter()
//        let enUSPosixLocale = NSLocale(localeIdentifier: "en_US_POSIX")
//        dateFormatter.locale = enUSPosixLocale as Locale!
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//        return dateFormatter.date(from: dateString)! as NSDate
//    }
//    class func Populate(data:NSData) -> jsonTMDb {
//        return Populate(dictionary: (JSONSerialization.data(withJSONObject: data, options: [] ) as? NSDictionary)!
//    }
//    
//    class func Populate(dictionary:NSDictionary) -> jsonTMDb {
//        let result = jsonTMDb()
//        result.Populate(dictionary: dictionary)
//        return result
//    }
//    
//}
//
