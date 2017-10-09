//
//  AddEntryViewController.swift
//  JournalApp
//
//  Created by Shena Yoshida on 9/5/16.
//  Copyright © 2016 Shena Yoshida. All rights reserved.
//

import UIKit

protocol AddItemDelegate {
    func userAddedItem(_ item: JournalEntry)
}

class AddEntryViewController: UIViewController {
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelHeadline: UILabel!
    
    var reviewData: JournalEntry?
    var rating: Int = 0
    var mediaType = ""
    var wasMade: Int = 0
    var itemDescription = ""
    var itemTitle = ""
    var name = ""
    
    var delegate: AddItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let detail = reviewData {
            itemTitle = detail.title
            name = detail.name
            mediaType = detail.type
            wasMade = detail.yearMade
            rating = detail.rating
            itemDescription = detail.note
        }
        
        labelHeadline.text = itemTitle
        labelSubtitle.text = name
        
        //        print("title: \(itemTitle), maker: \(name), type: \(mediaType), year made: \(wasMade), rating: \(rating), description: \(itemDescription)")
        
        setupButtons()
    }
    
    @IBAction func oneStarTapped(_ sender: AnyObject) {
        rating = 1
        buttonOne.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonTwo.setImage(UIImage(named: "star_unselected"), for: UIControlState())
        buttonThree.setImage(UIImage(named: "star_unselected"), for: UIControlState())
        buttonFour.setImage(UIImage(named: "star_unselected"), for: UIControlState())
        buttonFive.setImage(UIImage(named: "star_unselected"), for: UIControlState())
    }
    @IBAction func twoStarTapped(_ sender: AnyObject) {
        rating = 2
        buttonOne.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonTwo.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonThree.setImage(UIImage(named: "star_unselected"), for: UIControlState())
        buttonFour.setImage(UIImage(named: "star_unselected"), for: UIControlState())
        buttonFive.setImage(UIImage(named: "star_unselected"), for: UIControlState())
    }
    
    @IBAction func threeStarTapped(_ sender: AnyObject) {
        rating = 3
        buttonOne.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonTwo.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonThree.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonFour.setImage(UIImage(named: "star_unselected"), for: UIControlState())
        buttonFive.setImage(UIImage(named: "star_unselected"), for: UIControlState())
    }
    
    @IBAction func fourStarTapped(_ sender: AnyObject) {
        rating = 4
        buttonOne.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonTwo.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonThree.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonFour.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonFive.setImage(UIImage(named: "star_unselected"), for: UIControlState())
    }
    
    @IBAction func fiveStarTapped(_ sender: AnyObject) {
        rating = 5
        buttonOne.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonTwo.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonThree.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonFour.setImage(UIImage(named: "star_selected"), for: UIControlState())
        buttonFive.setImage(UIImage(named: "star_selected"), for: UIControlState())
    }
    
    func setupButtons() {
        rating = 0
        buttonOne.setImage(UIImage(named: "star_unselected"), for: UIControlState())
        buttonTwo.setImage(UIImage(named: "star_unselected"), for: UIControlState())
        buttonThree.setImage(UIImage(named: "star_unselected"), for: UIControlState())
        buttonFour.setImage(UIImage(named: "star_unselected"), for: UIControlState())
        buttonFive.setImage(UIImage(named: "star_unselected"), for: UIControlState())
    }
    
    @IBAction func addEntryButtonTapped(_ sender: AnyObject) {
        //        guard
        //            let myName = labelHeadline.text,
        //            let title = labelSubtitle.text
        //            else {
        //                return
        //            }
        
        //        print("title: \(itemTitle), maker: \(name), type: \(mediaType), year made: \(wasMade), rating: \(rating), description: \(itemDescription)")
        
        let itemToPass = JournalEntry(name: name, title: itemTitle, type: mediaType, rating: rating, note: itemDescription, image: "", yearMade: wasMade)
        delegate?.userAddedItem(itemToPass)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
