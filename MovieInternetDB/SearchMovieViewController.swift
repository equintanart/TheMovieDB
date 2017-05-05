//
//  SearchMovieViewController.swift
//  MovieInternetDB
//
//  Created by Erick Quintanar on 5/4/17.
//  Copyright © 2017 equintanart. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //The Movie Database API Key
    let myAPIKey = "b7bcf1fa4760f986fbb1635c71a33996"
    
    var movieTitleArray   = [String]()
    var overviewArray     = [String]()
    var releaseDateArray  = [String]()
    var voteAverageArray  = [Double]()
    var posterPathArray   = [String]()
    var backdropPathArray = [String]()
    
    @IBOutlet weak var searchActionButton: UIButton!
    @IBOutlet weak var searchTextField:    UITextField!
    @IBOutlet weak var moviesTableView:    UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITableView Delegate and DataSource
        moviesTableView.delegate = self as UITableViewDelegate
        moviesTableView.dataSource = self as UITableViewDataSource
        
        moviesTableView.rowHeight = 120
        moviesTableView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButon2(_ sender: UIButton) {
        
        // Search action button will clean all the arrays for any new Search
        movieTitleArray.removeAll()
        overviewArray.removeAll()
        releaseDateArray.removeAll()
        voteAverageArray.removeAll()
        posterPathArray.removeAll()
        backdropPathArray.removeAll()
        
        if let title = searchTextField.text {
            searchJSONCall(title: title)
        }
        moviesTableView.isHidden = false
        moviesTableView.reloadData()
    }
    
    func searchJSONCall(title: String) {
        let escapedString = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if let escapedString = escapedString {
            let stringURL = "https://api.themoviedb.org/3/search/movie?api_key=\(myAPIKey)&language=en-US&query=\(String(describing: escapedString))&page=1&include_adult=false"
            let requestURL: NSURL = NSURL(string: stringURL)!
            let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest as URLRequest) { (data, response, error) -> Void in
                guard let jsonData = data else { return }
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                if (statusCode == 200) {
                    do {
                        let json = try JSONSerialization.jsonObject(with: jsonData, options: [] ) as! [String : AnyObject]
                        if let results = json["results"] as? [[String: AnyObject]] {
                            for result in results {
                                if let originalTitle = result["original_title"] as? String  {
                                    self.movieTitleArray.append(originalTitle)
                                }
                                if let overview = result["overview"] as? String {
                                    self.overviewArray.append(overview)
                                }
                                if let releaseDate = result["release_date"] as? String {
                                    self.releaseDateArray.append(releaseDate)
                                }
                                if let voteAverage = result["vote_average"] as? Double {
                                    self.voteAverageArray.append(voteAverage)
                                }
                                
                                if let posterPath = result["poster_path"] as? String {
                                    self.posterPathArray.append(posterPath)
                                }
                                
                                if let backdropPath = result["backdrop_path"] as? String {
                                    self.backdropPathArray.append(backdropPath)
                                }
                            }
                            DispatchQueue.main.async(execute: {
                                self.moviesTableView.reloadData()
                            })
                        }
                    } catch {
                        print("Error with Json: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! TableViewCell
        
        // Configure the cell...
        let title = movieTitleArray[indexPath.row]
        cell.movieTitle.text = title
        let releaseDate = releaseDateArray[indexPath.row]
        cell.releaseDateLabel.text = releaseDate
        let voteAverage = voteAverageArray[indexPath.row]
        cell.voteAverageLabel.text = voteAverage.description
        let posterPath = posterPathArray[indexPath.row]
        if let checkedUrl = URL(string: "https://image.tmdb.org/t/p/original/\(posterPath)") {
            cell.moviePosterImage.contentMode = .scaleAspectFit
            cell.moviePosterImage.downloadedFrom(url: checkedUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailsViewController
        let title    = movieTitleArray[indexPath.row]
        let overview = overviewArray[indexPath.row]
        let backdrop = backdropPathArray[indexPath.row]
        let poster   = posterPathArray[indexPath.row]
        let rating   = voteAverageArray[indexPath.row]
        let release  = releaseDateArray[indexPath.row]
        detailViewController.movieTitle        = title
        detailViewController.overviewString    = overview
        detailViewController.backdropPathImage = backdrop
        detailViewController.posterPathImage   = poster
        detailViewController.ratingString      = rating
        detailViewController.releaseString     = release
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
