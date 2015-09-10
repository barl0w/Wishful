//
//  WishListViewController.swift
//  Wishful
//
//  Created by Scott Barlow on 8/24/15.
//  Copyright © 2015 Scott Barlow. All rights reserved.
//

import UIKit
import CoreData

class WishListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var wishes : [Wish] = []
    
    var selectedWish : Wish? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // MARK: - Load from CoreData upon launch:
        
        // makeSampleWish()
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let request = NSFetchRequest(entityName: "Wish")
        
        var results : [AnyObject]?
        
        do {
            
            results = try context.executeFetchRequest(request)
            
        } catch _ {
            
            results = nil
            
        }
        
        if results != nil {
            
            self.wishes = results! as! [Wish]
            
        }
        
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let request = NSFetchRequest(entityName: "Wish")
        
        var results : [AnyObject]?
        
        do {
            
            results = try context.executeFetchRequest(request)
            
        } catch _ {
            
            results = nil
            
        }
        
        if results != nil {
            
            self.wishes = results! as! [Wish]
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func makeSampleWish() {
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let wish = NSEntityDescription.insertNewObjectForEntityForName("Wish", inManagedObjectContext: context) as! Wish
        
        wish.desc = "Nike Shoes"
        wish.image = UIImageJPEGRepresentation(UIImage(named: "metcon.jpeg")!, 1)
        
        do {
            
            try context.save()
            
        } catch _ {
            
            
        }
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.wishes.count
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let wish = self.wishes[indexPath.row]
        cell.textLabel!.text = wish.desc
        cell.imageView!.image = UIImage(data: wish.image!)
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedWish = self.wishes[indexPath.row]
        self.performSegueWithIdentifier("wishDetailSegue", sender: self)
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        switch editingStyle {
            
        case .Delete:
            // remove the deleted item from the model
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            context.deleteObject(self.wishes[indexPath.row] as NSManagedObject)
            
            self.wishes.removeAtIndex(indexPath.row)
            
            do {
                
                try context.save()
                
            } catch _ {
                
                // Do nothing
                
            }
            
            // MARK: - Remove the deleted item from the tableView
            
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        default:
            return
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "wishDetailSegue" {
        
            let detailVC = segue.destinationViewController as! WishDetailViewController
            detailVC.wish = self.selectedWish
            
        }
        
    }


}

