//
//  Extension+UIColor.swift
//  Test
//
//  Created by Eugeny Matylitski on 23.08.22.
//

import Foundation
import UIKit

//MARK: much more comfortable init when we take a color with pipette tool from color cirlce

extension UIColor{
    public convenience init(r: CGFloat, g : CGFloat, b : CGFloat, alph : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alph)
    }
    
    static var testOrange : UIColor{
        return UIColor(r: 255, g: 110, b: 78, alph: 1)
    }
    
    static var testGrey : UIColor{
        return UIColor(r: 179, g: 179, b: 195, alph: 1)
    }
}
