//
//  FilterVC.swift
//  Test
//
//  Created by Eugeny Matylitski on 25.08.22.
//

import Foundation
import UIKit

final class FilterVC : UIViewController{
    @IBOutlet private var doneButton : UIButton!
    @IBOutlet private var backgroundView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBackgroundView()
    }
    
    func setupViews (){
        backgroundView.layer.cornerRadius = 20.0
        doneButton.layer.cornerRadius = 10.0
        doneButton.addTarget(self, action: #selector(doneButtonTap), for: .touchUpInside)
    }
    func setupBackgroundView(){
        backgroundView.layer.shadowColor = UIColor(r: 76, g: 95, b: 143, alph: 0.2).cgColor
        backgroundView.layer.shadowRadius = 5
        backgroundView.layer.shadowOpacity = 1
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    @objc func doneButtonTap(){
        dismiss(animated: true)
    }
    @IBAction private func exitDidTap(){
        dismiss(animated: true)
    }
    
}
