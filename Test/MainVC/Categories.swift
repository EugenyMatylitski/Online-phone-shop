//
//  File.swift
//  Test
//
//  Created by Eugeny Matylitski on 23.08.22.
//

import Foundation

struct Categories {
    let categories : [Category] = [Category(name:"Phones", imageName: "Phone"),
                                   Category(name:"Computers", imageName: "Computers"),
                                   Category(name:"Health", imageName: "Health"),
                                   Category(name:"Books", imageName: "Books")] 
}

struct Category {
    var name : String?
    var imageName : String?
}
