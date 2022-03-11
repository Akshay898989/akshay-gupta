//
//  MovieDetailViewController.swift
//  cricbuzz
//
//  Created by Akshay on 11/03/22.
//

import UIKit
import HCSStarRatingView
class MovieDetailViewController: UIViewController{
    // MARK: Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var duration_yearLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var segmentControlImage: UIImageView!
    @IBOutlet weak var segmentControlLabek: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var ratingView: HCSStarRatingView!
    @IBOutlet weak var plotLabel: UILabel!
    var movieDetailData:MovieDetail? = nil
    
    // MARK: ViewLifeCycle
   override func viewDidLoad() {
       super.viewDidLoad()
       posterImage.image = movieDetailData?.poster
       movieNameLabel.text = movieDetailData?.movieName
       duration_yearLabel.text = movieDetailData?.duration_year
       plotLabel.text = movieDetailData?.plot
       segmentControl.removeAllSegments()
       setUpSegments()
       segmentControl.selectedSegmentIndex = 0
       segmentControlClick(0)
       setRatingView()
       navigationItem.largeTitleDisplayMode = .never
   }
    
    // use to set up the segements based on source data
    func setUpSegments(){
        for index in 0..<(movieDetailData?.rating?.count ?? 0){
            segmentControl.insertSegment(withTitle: movieDetailData?.rating?[index].source.rawValue, at: index, animated: false)
                }
    }
    @IBAction func segmentControlClick(_ sender: Any) {
        let index = segmentControl.selectedSegmentIndex
        if segmentControl.selectedSegmentIndex<0{
            return
        }
        let title = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex)

        switch title {
        case "Internet Movie Database":
            segmentControlLabek.text = movieDetailData?.rating?[index].source.rawValue
            percentageLabel.text = movieDetailData?.rating?[index].value
            segmentControlImage.image = UIImage(named: "IMDB_Logo_2")
            if let value = movieDetailData?.rating?[index].value.split(separator: "/"),value.count>0,let dValue=Double(value[0]){
                ratingView.value = CGFloat(dValue/2)
            }
            
        case "Rotten Tomatoes" :
            segmentControlLabek.text = movieDetailData?.rating?[index].source.rawValue
            percentageLabel.text = movieDetailData?.rating?[index].value
            segmentControlImage.image = UIImage(named: "Rotten_Tomatoes")
            if let value = movieDetailData?.rating?[index].value.split(separator: "%"),value.count>0,let dValue=Double(value[0]){
                ratingView.value = CGFloat(dValue/20)
            }
        case "Metacritic":
            segmentControlLabek.text = movieDetailData?.rating?[index].source.rawValue
            percentageLabel.text = movieDetailData?.rating?[index].value
            segmentControlImage.image = UIImage(named: "Metacritic")
            if let value = movieDetailData?.rating?[index].value.split(separator: "/"),value.count>0,let dValue=Double(value[0]){
                ratingView.value = CGFloat(dValue/20)
            }
        default:
            break
        }
    }
    
    func setRatingView(){
        ratingView.accurateHalfStars = true
        ratingView.allowsHalfStars = true
        ratingView.minimumValue = 1
        ratingView.maximumValue = 5
        ratingView.filledStarImage = UIImage(named: "YelloStar")
        ratingView.emptyStarImage = UIImage(named: "GrayStar")
        ratingView.isUserInteractionEnabled = false
    }
     
}
