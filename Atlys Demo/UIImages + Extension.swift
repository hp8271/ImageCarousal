//
//  UIImages + Extension.swift
//  Atlys Demo
//
//  Created by Harsh Pranay on 07/09/24.
//

import Foundation
import UIKit


enum Images: String {
    case dubai1, dubai2, dubai3
}

extension UIImage {

    static func getImage( for image: Images?) -> UIImage? {

        if let img = image {
            return UIImage(named: img.rawValue)
        }
        return nil
    }

}
