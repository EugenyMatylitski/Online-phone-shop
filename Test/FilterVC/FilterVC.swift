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
    }
    
    func setupViews (){
        backgroundView.layer.cornerRadius = 20.0
        doneButton.layer.cornerRadius = 10.0
        doneButton.addTarget(self, action: #selector(doneButtonTap), for: .touchUpInside)
    }
    
    @objc func doneButtonTap(){
        dismiss(animated: true)
    }
    @IBAction private func exitDidTap(){
        dismiss(animated: true)
    }
    
}
