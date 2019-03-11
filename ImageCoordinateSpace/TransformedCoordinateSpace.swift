//
//  TransformedCoordinateSpace.swift
//  ImageCoordinateSpace
//
//  Created by Paul Zabelin on 2/17/16.
//
//

import UIKit

class TransformedCoordinateSpace: NSObject {
    let size: CGSize
    let converter: Converter

    lazy var bounds = CGRect(origin: .zero, size: size)

    init(size contentSize: CGSize, converter spaceConverter: Converter) {
        size = contentSize
        converter = spaceConverter
    }
}

extension TransformedCoordinateSpace: UICoordinateSpace {
    func convert(_ object: CGPoint, to space: UICoordinateSpace) -> CGPoint {
        return converter.convert(object, to: space)
    }
    func convert(_ object: CGRect, to space: UICoordinateSpace) -> CGRect {
        return converter.convert(object, to: space)
    }

    func convert(_ object: CGPoint, from space: UICoordinateSpace) -> CGPoint {
        return converter.convert(object, from: space)
    }
    func convert(_ object: CGRect, from space: UICoordinateSpace) -> CGRect {
        return converter.convert(object, from: space)
    }
}
