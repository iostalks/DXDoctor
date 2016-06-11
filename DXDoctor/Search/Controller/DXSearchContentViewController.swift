//
//  DXSearchContentViewController.swift
//  DXDoctor
//
//  Created by Jone on 16/3/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXSearchContentViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {

    var searchController: UISearchController!
    var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        
        self.searchController = UISearchController.init(searchResultsController: nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true

//
//        self.navigationItem.titleView = searchController.searchBar
//        
//        self.definesPresentationContext = true
        // Do any additional setup after loading the view.
        
        
//        searchBar = UISearchBar()
//        searchBar.barTintColor = UIColor.redColor()
//        searchBar.tintColor = UIColor.blueColor()
//        searchBar.barStyle = .Default
//        searchBar.delegate = self
//        searchBar.tintColor = DXSettingManager.themeColor
////
//        self.navigationItem.titleView = searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
