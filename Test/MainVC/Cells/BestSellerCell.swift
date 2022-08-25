//
//  BestSellerCell.swift
//  Test
//
//  Created by Eugeny Matylitski on 24.08.22.
//

import Foundation
import UIKit


final class BestSellerCell : UICollectionViewCell{
    @IBOutlet private weak var phoneImage : UIImageView!
    @IBOutlet private weak var priceWithoutDiscount : UILabel!
    @IBOutlet private weak var priceWithDiscount : UILabel!
    @IBOutlet private weak var phoneName : UILabel!
    @IBOutlet private weak var view : UIView!
    @IBOutlet private weak var isFavoritesView : UIView!
    @IBOutlet private weak var isFavoritesHeart : UIImageView!
    
    func setup(phone : BestSeller?, imageData: Data?){
        isFavoritesViewSetup()
        self.view.layer.cornerRadius = 20.0
        self.phoneImage.layer.cornerRadius = 20.0
        phoneImage.image = UIImage(data: imageData ?? Data())
        let phonePrice = "$\(phone?.discountPrice ?? 0)"
        priceWithoutDiscount.attributedText = NSAttributedString(string: phonePrice, attributes: [.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        priceWithDiscount.text = "$\(phone?.priceWithoutDiscount ?? 0)"
        phoneName.text = phone?.title
        if let isFavorite = phone?.isFavorites  {
            if isFavorite {
                isFavoritesHeart.image = UIImage(named: "heart_fill")?.withTintColor(.testOrange)
                isFavoritesHeart.tintColor = .testOrange
            }
        }
    }
    
    func isFavoritesViewSetup(){
        isFavoritesView.layer.shadowColor = UIColor.black.cgColor
        isFavoritesView.layer.shadowRadius = 8
        isFavoritesView.layer.shadowOpacity = 0.15
        isFavoritesView.layer.shadowOffset = CGSize(width: 0, height: 0)
        isFavoritesView.layer.cornerRadius = isFavoritesView.bounds.height / 2
    }
}
