//
//  JournalEntry.swift
//  JournalApp
//
//  Created by Shena Yoshida on 8/22/16.
//  Copyright © 2016 Shena Yoshida. All rights reserved.
//

import UIKit

class JournalEntry {
    
    let name: String
    let title: String
    let type: String
    let rating: Int
    let note: String
    let image: String
    let created: Date
    let yearMade: Int
    
    init (name: String, title: String, type: String, rating: Int = 0, note: String, image: String, created: Date = Date(), yearMade: Int) {
        self.name = name
        self.title = title
        self.type = type
        self.rating = rating
        self.note = note
        self.image = image
        self.created = created
        self.yearMade = yearMade
    }
  
}
