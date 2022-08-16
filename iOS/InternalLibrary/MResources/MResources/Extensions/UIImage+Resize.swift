//
//  UIImage+Resize.swift
//  MResources
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation

extension UIImage {
    func scaledToSize(_ newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
