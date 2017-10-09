//
//  DetailViewController.swift
//  JournalApp
//
//  Created by Shena Yoshida on 9/4/16.
//  Copyright © 2016 Shena Yoshida. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var constraintStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelHeadline: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var imageStarOne: UIImageView!
    @IBOutlet weak var imageStarTwo: UIImageView!
    @IBOutlet weak var imageStarThree: UIImageView!
    @IBOutlet weak var imageStarFour: UIImageView!
    @IBOutlet weak var imageStarFive: UIImageView!
    
    var rating: Int = 0
    var typeOfMedia: String = ""
    var descriptionText: String = ""
    var dateText = Date()
    
    var detailData: JournalEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let detail = detailData {
            labelHeadline.text = detail.title
            labelSubtitle.text = detail.name
            rating = detail.rating
            typeOfMedia = detail.type
            descriptionText = detail.note
            dateText = detail.created as Date
        }
        
        setupImageView()
        setupStarImages()
        setupDateLabel()
        setupTextView()
        setupStackView()
    }
    
    func setupStackView() {
        if UIScreen.main.sizeType == .iPhone5 || UIScreen.main.sizeType == .iPhone4 {
            constraintStackViewHeight.constant = 60.0
        }
    }
    
    // NOTE: fix detail view's text view...
    func setupTextView() {
        //        let theAttributedString = try! NSAttributedString(data: descriptionText.data(using: String.Encoding.utf8, allowLossyConversion: false)!, options: [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        
        //        textView.attributedText = theAttributedString
        //        textView.font = UIFont(name: "Helvetica", size: 15)
    }
    
    func setupDateLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        let dateString = formatter.string(from: dateText)
        labelDate.text = "Added: " + dateString
    }
    
    // text view begins at top
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func setupImageView() {
        if typeOfMedia == "Book" {
            imageView.image = UIImage(named: "book_selected")
        }
        if typeOfMedia == "Film" {
            imageView.image = UIImage(named: "movie_selected")
        }
        if typeOfMedia == "Album" {
            imageView.image = UIImage(named: "album_selected")
        }
    }
    
    func setupStarImages() {
        
        if rating == 0 {
            imageStarOne.image = UIImage(named: "star_unselected")
            imageStarTwo.image = UIImage(named: "star_unselected")
            imageStarThree.image = UIImage(named: "star_unselected")
            imageStarFour.image = UIImage(named: "star_unselected")
            imageStarFive.image = UIImage(named: "star_unselected")
        }
        if rating == 1 {
            imageStarOne.image = UIImage(named: "star_selected")
            imageStarTwo.image = UIImage(named: "star_unselected")
            imageStarThree.image = UIImage(named: "star_unselected")
            imageStarFour.image = UIImage(named: "star_unselected")
            imageStarFive.image = UIImage(named: "star_unselected")
        }
        if rating == 2 {
            imageStarOne.image = UIImage(named: "star_selected")
            imageStarTwo.image = UIImage(named: "star_selected")
            imageStarThree.image = UIImage(named: "star_unselected")
            imageStarFour.image = UIImage(named: "star_unselected")
            imageStarFive.image = UIImage(named: "star_unselected")
        }
        if rating == 3 {
            imageStarOne.image = UIImage(named: "star_selected")
            imageStarTwo.image = UIImage(named: "star_selected")
            imageStarThree.image = UIImage(named: "star_selected")
            imageStarFour.image = UIImage(named: "star_unselected")
            imageStarFive.image = UIImage(named: "star_unselected")
        }
        if rating == 4 {
            imageStarOne.image = UIImage(named: "star_selected")
            imageStarTwo.image = UIImage(named: "star_selected")
            imageStarThree.image = UIImage(named: "star_selected")
            imageStarFour.image = UIImage(named: "star_selected")
            imageStarFive.image = UIImage(named: "star_unselected")
        }
        if rating == 5 {
            imageStarOne.image = UIImage(named: "star_selected")
            imageStarTwo.image = UIImage(named: "star_selected")
            imageStarThree.image = UIImage(named: "star_selected")
            imageStarFour.image = UIImage(named: "star_selected")
            imageStarFive.image = UIImage(named: "star_selected")
        }
    }
    
}

