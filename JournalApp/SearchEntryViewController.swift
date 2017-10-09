//
//  SearchEntryViewController.swift
//  JournalApp
//
//  Created by Shena Yoshida on 9/4/16.
//  Copyright © 2016 Shena Yoshida. All rights reserved.
//

import UIKit

protocol PassItemDelegate {
    func passItemToRootView(_ item: JournalEntry)
}

class SearchEntryViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var buttonAlbum: UIButton!
    @IBOutlet weak var buttonBook: UIButton!
    @IBOutlet weak var buttonFilm: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var delegatePassItem: PassItemDelegate?
    var searchResultItems = [JournalEntry]()
    
    var searchMediaType: String = "musicArtist"
    var mediaType: String = "Album"
    var url: String = ""
    var itemsFromAPI: JournalEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()
        
        tableView.rowHeight = UITableViewAutomaticDimension // cell height matches text
        tableView.estimatedRowHeight = 105
        tableView.tableFooterView = UIView() // hide empty views
        
        textField.delegate = self
    }
    
    // MARK: - Actions
    
    @IBAction func albumButtonTapped(_ sender: AnyObject) {
        saveChoice("Album")
        albumSearchDefaults()
        clearTableViewIfFull()
    }
    
    @IBAction func bookButtonTapped(_ sender: AnyObject) {
        saveChoice("Book")
        bookSearchDefaults()
        clearTableViewIfFull()
    }
    
    @IBAction func filmButtonTapped(_ sender: AnyObject) {
        saveChoice("Film")
        filmSearchDefaults()
        clearTableViewIfFull()
    }
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK - NSUserDefaults
    
    func saveChoice(_ mediaPickType: String) {
        UserDefaults.standard.set(mediaPickType, forKey: "last used")
    }
    
    // MARK: - Button Logic
    
    func albumSearchDefaults() {
        searchMediaType = "musicArtist"
        mediaType = "Album"
        navigationItem.title = "Search For Album"
        buttonAlbum.setImage(UIImage(named: "album_selected"), for: UIControlState())
        buttonBook.setImage(UIImage(named: "book_unselected"), for: UIControlState())
        buttonFilm.setImage(UIImage(named: "movie_unselected"), for: UIControlState())
    }
    
    func bookSearchDefaults() {
        searchMediaType = "ebook"
        mediaType = "Book"
        navigationItem.title = "Search For Book"
        buttonAlbum.setImage(UIImage(named: "album_unselected"), for: UIControlState())
        buttonBook.setImage(UIImage(named: "book_selected"), for: UIControlState())
        buttonFilm.setImage(UIImage(named: "movie_unselected"), for: UIControlState())
    }
    
    func filmSearchDefaults() {
        searchMediaType = "movie"
        mediaType = "Film"
        navigationItem.title = "Search For Film"
        buttonAlbum.setImage(UIImage(named: "album_unselected"), for: UIControlState())
        buttonBook.setImage(UIImage(named: "book_unselected"), for: UIControlState())
        buttonFilm.setImage(UIImage(named: "movie_selected"), for: UIControlState())
    }
    
    func setupButtons() {
        let choice = UserDefaults.standard.object(forKey: "last used") as? String
        if let pick = choice { // unwrap it
            if pick == "Album" {
                albumSearchDefaults()
            }
            if pick == "Book" {
                bookSearchDefaults()
            }
            if pick == "Film" {
                filmSearchDefaults()
            }
        } else {
            albumSearchDefaults()
        }
    }
    
    func clearTableViewIfFull() {
        if searchResultItems.count > 0 {
            searchResultItems.removeAll()
            tableView.reloadData()
            textField.text = ""
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addEntryIdentifier" {
            if let detailViewController = segue.destination as? AddEntryViewController {
                detailViewController.delegate = self
                if let indexPath = tableView.indexPathForSelectedRow {
                    let itemToReview = searchResultItems[indexPath.row]
                    detailViewController.reviewData = itemToReview
                }
            }
        }
    }
    
}

// MARK: - Table View

extension SearchEntryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellIdentifier", for: indexPath) as! SearchTableViewCell
        
        let result = searchResultItems[indexPath.row]
        let convertedDate = String(result.yearMade)
        
        cell.labelTitle?.text = result.title
        cell.labelDetail?.text = ((result.name + " (") + convertedDate) + ")"
        
        return cell
    }
    
}

// MARK: - Text Field + API Call

extension SearchEntryViewController: UITextFieldDelegate {
    
    @IBAction func textFieldTextAdded(_ sender: AnyObject) {

        if let searchItem = textField.text {
            
            // remove spaces and additional characters for url
            let safeURL = searchItem.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            
            if mediaType == "Album" {
                url =  "https://itunes.apple.com/search?media=music&entity=album&term=\(safeURL)&limit=20"
            } else {
                url =  "https://itunes.apple.com/search?media=all&entity=\(searchMediaType)&term=\(safeURL)&limit=10"
            }
            
            // convert string to url
            if  let webURL = URL(string: url) {
                print("web url: \(webURL)")
                
                let dataTask = URLSession.shared.dataTask(with: webURL, completionHandler: { (iTunesData, response, error) in
                    
                    if let error = error {
                        print("error: \(error.localizedDescription).")
                        return
                    }
                    
                    guard let iTunesData = iTunesData else {
                        print("error no data")
                        return
                    }
                    
                    do {
                        if let object = try JSONSerialization.jsonObject(with: iTunesData, options: .allowFragments) as? [String: AnyObject] {
//                            print("\(object)")
//                            print("\(object["results"]![0]["amgArtistId"])")

                            if let results = object["results"] as? [[String: AnyObject]] {
                                
                                for artist in results {
                                    //print(artist["artistName"])
                                    
                                    if let name = artist["artistName"],
                                        let year = artist["releaseDate"],
                                        let image = artist["artworkUrl100"] {
                                        
                                        if self.mediaType == "Film" {
                                            if let description = artist["longDescription"],
                                                let title = artist["trackName"] {
                                                
                                                self.itemsFromAPI = JournalEntry(name: "Director: " + (name as! String), title: title as! String, type: self.mediaType, rating: 3, note: description as! String, image: image as! String, yearMade: year.intValue)
                                                
                                                print("FILM DETAILS: director: \(self.itemsFromAPI!.name), type: \(self.itemsFromAPI!.type), year: \(self.itemsFromAPI!.yearMade), description: \(self.itemsFromAPI!.note), title: \(self.itemsFromAPI!.title)")
                                            }
                                        }
                                        
                                        if self.mediaType == "Book" {
                                            if let title = artist["trackName"],
                                                let description = artist["description"] {
                                                
                                                self.itemsFromAPI = JournalEntry(name: "Author: " + (name as! String), title: title as! String, type: self.mediaType, rating: 0, note: description as! String, image: image as! String, yearMade: year.intValue)
                                            }
                                        }
                                        
                                        if self.mediaType == "Album" {
                                            if let album = artist["collectionName"] {
                                                self.itemsFromAPI = JournalEntry(name: "Artist: " + (name as! String), title: album as! String, type: self.mediaType, rating: 0, note: "", image: image as! String, yearMade: year.intValue)
                                            }
                                        }
                                        // append search results to array for TBV
                                        self.searchResultItems.append(self.itemsFromAPI!)
                                    }
                                }
                            }
                        }
                    } catch {
                        // handle error
                    }
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                        // do other things here, load images if necessary
                    })
                }) 
                dataTask.resume() // don't forget this
                
                // NOTE: for non HTTPS urls, an app transport security warning message may pop up in the console... we need to allow HTTP connections in the plist -> App Transport Security Settings, Allow Aribitrary Loads.
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchResultItems.removeAll()
        tableView.reloadData()
        return true
    }
}

extension SearchEntryViewController: AddItemDelegate {
    func userAddedItem(_ item: JournalEntry) {
       delegatePassItem?.passItemToRootView(item)
        print("\(item)")
    }
    
}



