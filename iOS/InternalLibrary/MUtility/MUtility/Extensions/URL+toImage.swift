//
//  URL+toImage.swift
//  MAUtility
//
//  Created by MBP0003 on 8/19/21.
//

import Foundation

public extension URL {
    func toImage(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: self) else {
                completion(nil)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
    }
}
