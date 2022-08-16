//
//  NSObject+RxDisposeBag.swift
//  MAUtility
//
//  Created by MBP0003 on 8/8/21.
//

import Foundation

// MARK: - AssociatedObject Methods

private func associatedObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    initialiser: () -> ValueType
)
-> ValueType {
    if let associated = objc_getAssociatedObject(base, key)
        as? ValueType { return associated }
    let associated = initialiser()
    objc_setAssociatedObject(
        base,
        key,
        associated,
        .OBJC_ASSOCIATION_RETAIN
    )
    return associated
}

private func associateObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    value: ValueType
) {
    objc_setAssociatedObject(
        base,
        key,
        value,
        .OBJC_ASSOCIATION_RETAIN
    )
}
