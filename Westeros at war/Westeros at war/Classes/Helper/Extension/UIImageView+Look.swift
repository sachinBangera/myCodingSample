//
//  UIImageView+Look.swift
//  FHKiosk
//
//  Created by Sachin on 28/04/16.
//  Copyright © 2016 uirevolution. All rights reserved.
//

import Foundation
import AlamofireImage
import UIKit

extension UIImageView {
    
    func setImageWithUrl(url : NSURL? ,compltion : BlockResponder?) {
        if let l_url = url {
            self.af_setImageWithURL(l_url, placeholderImage: UIImage.placeHolderImage, filter: nil, imageTransition: .CrossDissolve(0.20) , completion: {
                [weak self]closureResponse in
                if let weakSelf = self {
                    if let l_compltion = compltion {
                        l_compltion(response: nil, sender: weakSelf)
                    }
                }
            })
        } else {
            self.image = UIImage.placeHolderImage
        }
    }
    
    func setImageWithUrlWithCornerRadius(url : NSURL) {
        let filter = RoundedCornersFilter(radius: 2.0)
        self.af_setImageWithURL(url, placeholderImage: UIImage.placeHolderImageRoundedCorner, filter: filter, imageTransition: .CrossDissolve(0.20))
    }
    
    func setUserImageWithUrl(url : NSURL) {
        self.af_setImageWithURL(url, placeholderImage: UIImage.placeHolderUserImage, filter: nil, imageTransition: .CrossDissolve(0.20))
    }

    func setUserImageWithUrlWithCornerRadius(url : NSURL) {
        let filter = RoundedCornersFilter(radius: 15.0)
        self.af_setImageWithURL(url, placeholderImage: UIImage.placeHolderUserImageRounded, filter: filter, imageTransition: .CrossDissolve(0.20))
    }
    
    func setGreyScaleImageWithUrl(url : NSURL?) {
        if let l_url = url {
            let greyScale = CoreImageFilter(filterName: "CIPhotoEffectMono", parameters: nil)
            self.af_setImageWithURL(l_url, placeholderImage: UIImage.placeHolderImage, filter: greyScale, imageTransition: .CrossDissolve(0.20))
        } else {
            self.image = UIImage.placeHolderImage
        }
    }
}

public struct CoreImageFilter: ImageFilter {
    
    let filterName: String
    let parameters: [String: AnyObject]
    
    public init(filterName : String, parameters : [String : AnyObject]?) {
        self.filterName = filterName
        self.parameters = parameters ?? [:]
    }
    
    public var filter: UIImage -> UIImage {
        return { image in
            return image.af_imageWithAppliedCoreImageFilter(self.filterName, filterParameters: self.parameters) ?? image
        }
    }
}