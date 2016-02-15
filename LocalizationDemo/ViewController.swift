//
//  ViewController.swift
//  LocalizationDemo
//
//  Created by Gabriel Theodoropoulos on 30/10/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
    var moviesData : NSArray?
    var selectedMovieIndex:Int?
    

    @IBOutlet weak var lblMovieInformation: UILabel!
    
    @IBOutlet weak var imgFlag: UIImageView!
    
    @IBOutlet weak var tblMovieInformation: UITableView!
    
    @IBOutlet weak var btnMoviePicker: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set the default selected movie index.
        selectedMovieIndex = 0
        
        // Load the movies data from the .plist file.
        loadMoviesData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showMoviesList(sender: AnyObject) {

    }
    
    func loadMoviesData(){
        // Load the movies data. Note that we assume that the file always exists so we don't check it.
        let moviesDataPath = NSBundle.mainBundle().pathForResource("MoviesData", ofType: "plist")
        moviesData = NSArray(contentsOfFile: moviesDataPath!)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        let movieDataDictionary : NSDictionary = moviesData?.objectAtIndex(selectedMovieIndex!) as! NSDictionary
        switch indexPath.row{
        case 0:
            // Dequeue the proper cell.
            cell = tableView.dequeueReusableCellWithIdentifier("idCellTitle", forIndexPath: indexPath) as UITableViewCell
            //Set the cell's title label text
            cell?.textLabel?.text = movieDataDictionary.objectForKey("Movie Title") as? String
            break
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("idCellCategory", forIndexPath: indexPath) as UITableViewCell
            let categoriesArray = movieDataDictionary.objectForKey("Category") as! [String]
            var allCategories = String()
            
            for aCategory in categoriesArray{
                allCategories += NSLocalizedString(aCategory, comment: "The category of the movie") + " "
            }
            cell?.textLabel?.text = allCategories
            break
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("idCellRating", forIndexPath: indexPath) as UITableViewCell
            
            cell?.textLabel?.text = getFormattedStringFromNumber(movieDataDictionary.valueForKey("Rating") as! Double) + " / 10"
            break
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("idCellReleaseDate", forIndexPath: indexPath) as UITableViewCell
            cell?.textLabel?.text = getFormattedStringFromDate(movieDataDictionary.objectForKey("Release Date") as! NSDate)
            break
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("idCellDuration", forIndexPath: indexPath) as UITableViewCell
            
            let duration = movieDataDictionary.objectForKey("Duration") as! Int
            cell?.textLabel?.text = String(duration) + " " + NSLocalizedString("minutes", comment: "The minutes literal for the movie duration")
            break
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier("idCellDirector", forIndexPath: indexPath) as UITableViewCell
            
            cell?.textLabel?.text = movieDataDictionary.objectForKey("Director") as? String
            break
        case 6:
            cell = tableView.dequeueReusableCellWithIdentifier("idCellStars", forIndexPath: indexPath) as UITableViewCell
            cell?.textLabel?.text = movieDataDictionary.objectForKey("Stars") as? String
            break
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("idCellLink", forIndexPath: indexPath) as? UITableViewCell
            cell?.textLabel?.text = movieDataDictionary.objectForKey("Link") as? String
            break
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // Format string
    func getFormattedStringFromNumber(number: Double) -> String{
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        return numberFormatter.stringFromNumber(number)!
    }
    
    func getFormattedStringFromDate(aDate: NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        return dateFormatter.stringFromDate(aDate)
    }
}

