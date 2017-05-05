//
//  DetailsViewController.swift
//  MovieInternetDB
//
//  Created by Erick Quintanar on 5/4/17.
//  Copyright © 2017 equintanart. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var movieTitle        = String()
    var overviewString    = String()
    var backdropPathImage = String()
    var posterPathImage   = String()
    var ratingString      = Double()
    var releaseString     = String()
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel:   UILabel!
    @IBOutlet weak var backdropImage:   UIImageView!
    @IBOutlet weak var posterImage:     UIImageView!
    @IBOutlet weak var ratingLabel:     UILabel!
    @IBOutlet weak var releaseLabel:    UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movieTitleLabel.text = movieTitle
        overviewLabel.text   = overviewString
        ratingLabel.text     = ratingString.description
        releaseLabel.text    = releaseString
        
        // Backdrop and Poster Image will be downloaded in the background
        let posterImageURL = "https://image.tmdb.org/t/p/original/\(posterPathImage)"
        posterImage.downloadedFrom(link: posterImageURL)
        let backdropImageURL = "https://image.tmdb.org/t/p/original/\(backdropPathImage)"
        backdropImage.downloadedFrom(link: backdropImageURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension UIImageView {
    func downloadedFrom2(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom2(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom2(url: url, contentMode: mode)
    }
}


