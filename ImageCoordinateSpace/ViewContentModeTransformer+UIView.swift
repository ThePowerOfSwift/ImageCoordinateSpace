//
//  ContentAdjustment.swift
//  ImageCoordinateSpace
//
//  Created by Paul Zabelin on 2/14/16.
//
//

import UIKit

extension UIView {
    var viewContentModeTransformer: ViewContentModeTransformer {
        get {
            return ViewContentModeTransformer(bounds: bounds.size,
                                              content: intrinsicContentSize,
                                              mode: contentMode)
        }
    }
}

extension ViewContentModeTransformer {
    func transform() -> CGAffineTransform {
        return sizeTransformer.isIdentity() ? .identity : contentToViewTransform()
    }

    func transformingToSpace(_ space: UICoordinateSpace) -> UICoordinateSpace {
        return TransformedCoordinateSpace(
            size: sizeTransformer.contentSize,
            transform: transform,
            destination: space
        )
    }
}
