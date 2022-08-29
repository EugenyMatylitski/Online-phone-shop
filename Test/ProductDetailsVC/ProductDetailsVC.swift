//
//  ProductDetailsVC.swift
//  Test
//
//  Created by Eugeny Matylitski on 26.08.22.
//

import Foundation
import UIKit
import HSCycleGalleryView


final class ProductDetailsVC : UIViewController{
    @IBOutlet private weak var phoneNameLabel : UILabel!
    @IBOutlet private weak var phonePriceLabel : UILabel!
    @IBOutlet private weak var cpuLabel : UILabel!
    @IBOutlet private weak var cameraLabel : UILabel!
    @IBOutlet private weak var ramLabel : UILabel!
    @IBOutlet private weak var sdLabel : UILabel!
    @IBOutlet private weak var minSsdButton : UIButton!
    @IBOutlet private weak var maxSsdButton : UIButton!
    @IBOutlet private weak var addToCartButtonView : UIView!
    @IBOutlet private weak var backgroundView : UIView!
    @IBOutlet private weak var firstColor: UIView!
    @IBOutlet private weak var secondColor: UIView!
    @IBOutlet private weak var firstCheckmark: UIImageView!
    @IBOutlet private weak var secondCheckmark: UIImageView!
    @IBOutlet private var rating : [UIImageView]!

    

    var productDetails : ProductDetailsModel?{
        didSet{
            print(productDetails)
            setupInfo()
            setupViews()
        }
    }
    let viewModel = ProductDetailsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadProductDetails { data in
            self.productDetails = data
        }
        setupViews()
        
    }
    
    
    func setupViews(){
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        minSsdButton.layer.cornerRadius = 10.0
        maxSsdButton.layer.cornerRadius = 10.0
        addToCartButtonView.layer.cornerRadius = 10.0
        backgroundView.layer.cornerRadius = 20.0
        
        guard let productDetails = productDetails else {return}
        firstColor.backgroundColor = UIColor(hex: productDetails.color[0])
        secondColor.backgroundColor = UIColor(hex: productDetails.color[1])
        firstColor.layer.cornerRadius = firstColor.bounds.height / 2
        secondColor.layer.cornerRadius = secondColor.bounds.height / 2
        secondCheckmark.isHidden = true
        
    }
    
    func setupInfo(){
        guard let productDetails = productDetails else {
            return
        }
       
        cameraLabel.text = productDetails.camera
        cpuLabel.text = productDetails.CPU
        ramLabel.text = productDetails.sd
        sdLabel.text = productDetails.ssd
        phoneNameLabel.text = productDetails.title
        phonePriceLabel.text = "$\(Double(productDetails.price) ?? 0.0)"
        minSsdButton.setTitle("\(productDetails.capacity[0]) GB", for: .normal)
        maxSsdButton.setTitle("\(productDetails.capacity[0]) gb", for: .normal)
        for (index, value) in rating.enumerated(){
            if (Double(index)+1) < productDetails.rating{
                value.image = UIImage(systemName: "star.fill")
                value.tintColor = .starColor
            }else if (Double(index)+1 > productDetails.rating) && Double(index) < productDetails.rating{
                value.image = UIImage(systemName: "star.leadinghalf.fill")
                value.tintColor = .starColor
            }
        }
    }
    
    @IBAction func changeColor(recognizer : UITapGestureRecognizer){
        guard let tappedView = recognizer.view else {return}

        if  !firstCheckmark.isHidden && tappedView == secondColor{
            firstCheckmark.isHidden = true
            secondCheckmark.isHidden = false
        }else if !secondCheckmark.isHidden && tappedView == firstColor{
            firstCheckmark.isHidden = false
            secondCheckmark.isHidden = true
        }
        
    }
}

