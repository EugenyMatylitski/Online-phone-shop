//
//  SliderCell.swift
//  Test
//
//  Created by Eugeny Matylitski on 23.08.22.
//

import Foundation
import UIKit


final class HotSalesCell : UICollectionViewCell{
    @IBOutlet private weak var image : UIImageView!
    @IBOutlet private weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet private weak var phoneName : UILabel!
    @IBOutlet private weak var phoneTitle : UILabel!
    @IBOutlet private weak var isNewView : UIView!
    @IBOutlet private weak var buyButton : UIButton!
    var imageFromData : UIImage?{
        didSet{
            image.isHidden = false
            image.image = imageFromData
            image.layer.cornerRadius = 8.0
        }
    }
    
    func setup(info : HomeStore?){
        backgroundView?.backgroundColor = .black
        activityIndicator.startAnimating()
        phoneName.text = info?.title ?? ""
        phoneTitle.text = info?.subtitle ?? ""
        if  let isNew = info?.isNew{
            self.isNewView.isHidden = false
        }else{
            self.isNewView.isHidden = true
        }
        isNewView.layer.cornerRadius = isNewView.frame.height / 2
        buyButton.layer.cornerRadius = 5.0
    }
    
}
