//
//  UIImageView+Download.swift
//  MUtility
//
//  Created by Quang Phu C. M. on 7/1/22.
//

import Foundation
import SDWebImage
import UIKit

extension UIImageView {
    public func downloaded(
        from urlString: String?,
        placeHolder: UIImage? = nil,
        completion: ((_ imageSize: UIImage?) -> Void)? = nil
    ) {
        self.image = placeHolder
        guard let urlString = urlString else {
            completion?(placeHolder)
            return
        }
        let url = URL(string: urlString)

        self.sd_setImage(with: url, placeholderImage: placeHolder) { image, _, _, _ in
            completion?(image)
        }
    }
}
