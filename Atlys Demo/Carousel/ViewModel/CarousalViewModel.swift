//
//  CarousalViewModel.swift
//  Atlys Demo
//
//  Created by Harsh Pranay on 08/09/24.
//

import Foundation
import UIKit

final class CarousalViewModel {
    let deviceWidth = UIScreen.main.bounds.width
    let images: [Images]

    var centerImageWidth: CGFloat {
        return deviceWidth * 0.75
    }

    // Set the size for the side images (remaining 25% divided between two images)
    var sideImageWidth: CGFloat {
        return deviceWidth * 0.25 / 2
    }

    init(images: [Images] =  [.dubai1, .dubai2, .dubai3]) {
        self.images = images
    }
}
