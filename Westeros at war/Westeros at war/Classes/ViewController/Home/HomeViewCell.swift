//
//  HomeViewCell.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

import UIKit

class HomeViewCell: FoldingCell {
    
    var detailsAction : BlockResponder?

    @IBOutlet weak var typeSpecial: UILabel!
    @IBOutlet weak var kingImageView: UIImageView!
    @IBOutlet weak var kingsNameLabel: UILabel!
    @IBOutlet weak var kingsRating: UILabel!
    
    @IBOutlet weak var winCount: UILabel!
    @IBOutlet weak var lostCount: UILabel!
    @IBOutlet weak var drawCount: UILabel!
    
    @IBOutlet weak var kingsRatingV: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var kingsAction: UILabel!
    @IBOutlet weak var nameOfKing: UILabel!
    @IBOutlet weak var kingsPicView: UIImageView!
    
    @IBOutlet weak var startsRatingView: UIImageView!
    
    @IBOutlet weak var winCountO: UILabel!
    @IBOutlet weak var lostcountO: UILabel!
    
    @IBOutlet weak var attackCount: UILabel!
    @IBOutlet weak var defendedCount: UILabel!
    
    var king : King?
    
    override func awakeFromNib() {
        
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        
        super.awakeFromNib()
    }
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    func configureCellWithKingInfo(){
        
        self.typeSpecial.text = self.king?.getActionType()
        self.kingImageView.image = UIImage(named: (self.king?.imageName)!)
        self.kingsNameLabel.text = self.king?.name
        self.kingsRating.text = "Battle Rating : " + (self.king?.rating.description)!
        self.winCount.text = self.king?.winCount.description
        self.lostCount.text = self.king?.lossCount.description
        
        self.kingsRatingV.text = "#" + (self.king?.rating.description)!
        self.posterImageView.image = UIImage(named: (self.king?.getActionType())!)
        
        self.kingsAction.text = self.king?.getActionTitle()
        self.nameOfKing.text = self.king?.name
        
        self.kingsPicView.image =  UIImage(named: (self.king?.imageName)!)
        self.startsRatingView.image = UIImage(named: Utility.getMeRated((self.king?.rating)!))
        
        self.winCountO.text = self.king?.winCount.description
        self.lostcountO.text  = self.king?.lossCount.description
        self.attackCount.text =  self.king?.attackcount.description
        self.defendedCount.text = self.king?.defendcount.description
    }
    
    
    @IBAction func readMoreAction(sender: AnyObject) {
        if let theDetailsAction = self.detailsAction {
            theDetailsAction(response: self, sender: sender)
        }
    }
}
