//
//  UIImageView+UICoordinatedSpace.swift
//  ImageCoordinateSpace
//
//  Created by Paul Zabelin on 2/13/16.
//
//

import UIKit

public class ImageViewSpace : NSObject, UICoordinateSpace {
    var imageView : UIImageView

    init(view v: UIImageView) {
        imageView = v
        super.init()
    }

    public var bounds: CGRect {
        return CGRect(origin: CGPointZero, size: imageView.image!.size)
    }

    public func convertPoint(point: CGPoint, toCoordinateSpace coordinateSpace: UICoordinateSpace) -> CGPoint {
        let imageSize = imageView.image!.size
        let viewSize  = imageView.bounds.size
        let widthRatio = viewSize.width / imageSize.width
        let heightRatio = viewSize.height / imageSize.height
        let mode = imageView.contentMode
        let transform : CGAffineTransform!

        func widthDiff() -> CGFloat {
            return viewSize.width - imageSize.width
        }
        func heightDiff() -> CGFloat {
            return viewSize.height - imageSize.height
        }
        enum Factor : CGFloat {
            case none = 0
            case half = 0.5
            case full = 1
        }

        func translateWithFactors(tx:CGFloat, _ ty:CGFloat, _ xFactor:Factor, _ yFactor:Factor) -> CGAffineTransform {
            return CGAffineTransformMakeTranslation(tx * xFactor.rawValue, ty * yFactor.rawValue)
        }

        func halfTranslate(tx:CGFloat, _ ty:CGFloat) -> CGAffineTransform {
            return translateWithFactors(tx, ty, .half, .half)
        }
        
        func translate(xFactor:Factor, _ yFactor:Factor) -> CGAffineTransform {
            return translateWithFactors(widthDiff(), heightDiff(), xFactor, yFactor)
        }

        switch mode {
        case .ScaleAspectFit, .ScaleAspectFill:
            let scale = mode == .ScaleAspectFill ? max(widthRatio, heightRatio) : min(widthRatio, heightRatio)
            transform = CGAffineTransformScale(halfTranslate(
                viewSize.width  - imageSize.width  * scale,
                viewSize.height  - imageSize.height  * scale
                ), scale, scale)
            break
        case .ScaleToFill, .Redraw:
            transform = CGAffineTransformMakeScale(widthRatio, heightRatio)
        case .Center:
            transform = translate(.half, .half)
        case .Left:
            transform = translate(.none, .half)
        case .Right:
            transform = translate(.full, .half)
        case .TopRight:
            transform = translate(.full, .none)
        case .Bottom:
            transform = translate(.half, .full)
        case .BottomLeft:
            transform = translate(.none, .full)
        case .BottomRight:
            transform = translate(.full, .full)
        case .Top:
            transform = translate(.half, .none)
        case .TopLeft:
            transform = CGAffineTransformIdentity
        }
        let viewPoint = CGPointApplyAffineTransform(point, transform)
        return imageView.convertPoint(viewPoint, toCoordinateSpace: coordinateSpace)
    }

    public func convertPoint(point: CGPoint, fromCoordinateSpace coordinateSpace: UICoordinateSpace) -> CGPoint {
        return CGPointZero
    }

    public func convertRect(imageRect: CGRect, toCoordinateSpace coordinateSpace: UICoordinateSpace) -> CGRect {
        let imageBottomRight = CGPoint(x: CGRectGetMaxX(imageRect), y: CGRectGetMaxY(imageRect))

        let viewTopLeft     = convertPoint(imageRect.origin, toCoordinateSpace: coordinateSpace)
        let viewBottomRight = convertPoint(imageBottomRight, toCoordinateSpace: coordinateSpace)

        let viewRectSize = CGSizeMake(abs(viewBottomRight.x - viewTopLeft.x), abs(viewBottomRight.y - viewTopLeft.y))
        let viewRect = CGRect(origin: viewTopLeft, size: viewRectSize)
        return viewRect;
    }

    public func convertRect(rect: CGRect, fromCoordinateSpace coordinateSpace: UICoordinateSpace) -> CGRect {
        return CGRectZero
    }

}

public extension UIImageView {
    func imageCoordinatedSpace() -> UICoordinateSpace {
        return ImageViewSpace(view: self)
    }
}