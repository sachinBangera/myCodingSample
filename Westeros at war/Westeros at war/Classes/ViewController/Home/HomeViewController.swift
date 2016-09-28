//
//  HomeViewController.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

import UIKit
import BubbleTransition


class HomeViewController: UIViewController,UISearchBarDelegate,UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let transition = BubbleTransition()
    var transitionButton: UIButton!
    
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    
    var kRowsCount = 100
    let manager = ServiceManager.sharedManager
    var cellHeights = [CGFloat]()
    
     var kings = [King]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCellHeightsArray()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.getBattleData()
        self.searchBar.showsCancelButton = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: configure
    func createCellHeightsArray() {
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }
    
    func getBattleData(){
        self.showHUD()
        BattleManager.sharedManager.getAllBattleDetails {
            [weak self](data,sender, error) -> Void in
            if let weakSelf = self {
                weakSelf.hideHUD()
                if error == nil {
                    weakSelf.createCellHeightsArray()
                    weakSelf.makeDataSource()
                } else {
                    Utility.displayAlertWith(weakSelf, title: "Error", message: "Something went wrong, Please try again later!", leftTitle: nil, rightTitle: "OK", completionHandler: nil)
                }
            }
        }
    }
    
    func makeDataSource(){
        self.kings = BattleManager.sharedManager.kigsList
        self.kRowsCount = self.kings.count
        self.searchTableView.reloadData()
    }
    
    func getDataFoeSearch(search : String?){
        if let theSearch = search where search?.characters.count > 0 {
            let kingsHolder = self.kings
            self.kings.removeAll()
            for king in kingsHolder {
                if king.name.containsString(theSearch) {
                    self.kings.append(king)
                }
            }
            self.kings = self.kings.sort({ $0.rating > $1.rating })
            self.kRowsCount = self.kings.count
            self.searchTableView.reloadData()
        } else {
            self.makeDataSource()
        }
    }
    
    //MARK: Search
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        self.view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.getDataFoeSearch(searchBar.text)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
        
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let textOld : NSString = NSString(string: (searchBar.text!))
        let checkString = textOld.stringByReplacingCharactersInRange(range, withString: text as String)
        self.getDataFoeSearch(checkString)
        return true
    }
    

    func showDetailsFrom(sender : UIButton) {
        self.transitionButton = sender
        let detailsContrl = UIStoryboard.get_ViewControllerFromStoryboard(Storyboard.main, storyBoardIdentifier: DetailsViewController.identifier) as! DetailsViewController
        detailsContrl.transitioningDelegate = self
        detailsContrl.modalPresentationStyle = .Custom
        self.presentViewController(detailsContrl, animated: true, completion: nil)
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint =  self.transitionButton.convertPoint(transitionButton.center, toView: self.view)
        transition.bubbleColor = UIColor(red: 254/256.0, green: 190/256.0, blue: 22/256.0, alpha: 1.0)
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = self.transitionButton.convertPoint(transitionButton.center, toView: self.view)
        transition.bubbleColor = UIColor(red: 254/256.0, green: 190/256.0, blue: 22/256.0, alpha: 1.0)
        return transition
    }
    
}


extension HomeViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.kings.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard case let cell as HomeViewCell = cell else {
            return
        }
        
        cell.backgroundColor = UIColor.clearColor()
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.selectedAnimation(true, animated: false, completion: nil)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FoldingCell", forIndexPath: indexPath) as! HomeViewCell
        cell.king = self.kings[indexPath.row]
        cell.configureCellWithKingInfo()
        cell.detailsAction = {
            [weak self](response , sender) -> Void in
            if let weakSelf = self , button = sender as? UIButton{
                weakSelf.showDetailsFrom(button)
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
}

extension HomeViewController : UITableViewDelegate,UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.view.endEditing(true)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
    }
    
    
}