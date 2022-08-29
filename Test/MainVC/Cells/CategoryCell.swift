//
//  CategoryCell.swift
//  Test
//
//  Created by Eugeny Matylitski on 23.08.22.
//

import Foundation
import UIKit


final class CategoryCell : UICollectionViewCell{
    
    @IBOutlet private weak var circle : UIView!
    @IBOutlet private weak var categoryImage : UIImageView!
    @IBOutlet private weak var categoryName : UILabel!
    override var isSelected: Bool{
        didSet{
            if isSelected{
                circle.backgroundColor = .testOrange
                categoryImage.tintColor = .white
                categoryName.textColor = .testOrange
            }else {
                circle.backgroundColor = .white
                categoryImage.tintColor = .testGrey
                categoryName.textColor = .black
            }
        }
    }
    var category : Category?{
        didSet{
            circle.layer.cornerRadius = circle.frame.height / 2
            categoryImage.image = UIImage(named: category?.imageName ?? "")
            categoryImage.tintColor = .testGrey
            categoryName.text = category?.name ?? ""
            setupShadow()
        }
    }
    func setupShadow (){
        circle.layer.shadowColor =  UIColor(r: 167, g: 171, b: 201, alph: 0.15).cgColor
        circle.layer.shadowRadius = 5
        circle.layer.shadowOpacity = 1
        circle.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    
    
}
