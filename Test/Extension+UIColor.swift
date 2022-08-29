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
    
    static var starColor : UIColor{
        return UIColor(r: 255, g: 184, b: 0, alph: 1)
    }
    
    convenience init?(hex : String){
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        let length = hexSanitized.count
        var rgb : UInt64 = 0
        var r : CGFloat = 0.0
        var g : CGFloat = 0.0
        var b : CGFloat = 0.0
        var a : CGFloat = 1.0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {return nil}
        
        r = CGFloat((rgb & 0xFF0000) >> 16)  / 255.0
        g = CGFloat((rgb & 0x00FF00) >> 8)  / 255.0
        b = CGFloat((rgb & 0x0000FF)) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
}
