//
//  ImageViewSpace.swift
//  ImageCoordinateSpace
//
//  Created by Paul Zabelin on 2/14/16.
//
//

import UIKit

enum Factor : CGFloat {
    case none = 0
    case half = 0.5
    case full = 1
}

func translateWithFactors(tx tx:CGFloat, ty:CGFloat, xFactor:Factor, yFactor:Factor) -> CGAffineTransform {
    return CGAffineTransformMakeTranslation(tx * xFactor.rawValue, ty * yFactor.rawValue)
}

func halfTranslate(tx tx:CGFloat, ty:CGFloat) -> CGAffineTransform {
    return translateWithFactors(tx:tx, ty:ty, xFactor:.half, yFactor:.half)
}


class ImageViewSpace : NSObject, UICoordinateSpace {
    var imageView : UIImageView

    init(view: UIImageView) {
        imageView = view
        super.init()
    }

    var bounds: CGRect {
        return imageView.image == nil ? imageView.bounds : CGRect(origin: CGPointZero, size: imageView.image!.size)
    }

    func convertPoint(point: CGPoint, toCoordinateSpace coordinateSpace: UICoordinateSpace) -> CGPoint {
        return imageView.convertPoint(imageToViewPoint(point), toCoordinateSpace: coordinateSpace)
    }

    func convertPoint(point: CGPoint, fromCoordinateSpace coordinateSpace: UICoordinateSpace) -> CGPoint {
        return viewToImagePoint(imageView.convertPoint(point, fromCoordinateSpace: coordinateSpace))
    }

    func convertRect(imageRect: CGRect, toCoordinateSpace coordinateSpace: UICoordinateSpace) -> CGRect {
        return imageView.convertRect(convertRect(imageRect, using: imageToViewPoint), toCoordinateSpace: coordinateSpace)
    }

    func convertRect(rect: CGRect, fromCoordinateSpace coordinateSpace: UICoordinateSpace) -> CGRect {
        return convertRect(imageView.convertRect(rect, fromCoordinateSpace: coordinateSpace), using: viewToImagePoint)
    }

    // MARK: private

    private func imageToViewTransform() -> CGAffineTransform {
        let viewSize  = imageView.bounds.size
        let imageSize = imageView.image == nil ? viewSize : imageView.image!.size
        
        func translate(xFactor:Factor, _ yFactor:Factor) -> CGAffineTransform {
            return translateWithFactors(
                tx: viewSize.width - imageSize.width,
                ty: viewSize.height - imageSize.height,
                xFactor: xFactor,
                yFactor: yFactor
            )
        }

        let widthRatio = viewSize.width / imageSize.width
        let heightRatio = viewSize.height / imageSize.height

        let contentMode = imageView.contentMode
        switch contentMode {
        case .ScaleAspectFit, .ScaleAspectFill:
            let scale = contentMode == .ScaleAspectFill ? max(widthRatio, heightRatio) : min(widthRatio, heightRatio)
            return CGAffineTransformScale(halfTranslate(
                tx: viewSize.width  - imageSize.width  * scale,
                ty: viewSize.height  - imageSize.height  * scale
                ), scale, scale)
        case .ScaleToFill, .Redraw:
            return CGAffineTransformMakeScale(widthRatio, heightRatio)
        case .Center:
            return translate(.half, .half)
        case .Left:
            return translate(.none, .half)
        case .Right:
            return translate(.full, .half)
        case .TopRight:
            return translate(.full, .none)
        case .Bottom:
            return translate(.half, .full)
        case .BottomLeft:
            return translate(.none, .full)
        case .BottomRight:
            return translate(.full, .full)
        case .Top:
            return translate(.half, .none)
        case .TopLeft:
            return CGAffineTransformIdentity
        }
    }

    private func viewToImageTransform() -> CGAffineTransform {
        return CGAffineTransformInvert(imageToViewTransform())
    }

    private func imageToViewPoint(point: CGPoint) -> CGPoint {
        return CGPointApplyAffineTransform(point, imageToViewTransform())
    }

    private func viewToImagePoint(point: CGPoint) -> CGPoint {
        return CGPointApplyAffineTransform(point, viewToImageTransform())
    }

    private func convertRect(rect:CGRect, using convertPoint:((CGPoint) -> CGPoint)) -> CGRect {
        let rectBottomRight = CGPoint(x: CGRectGetMaxX(rect), y: CGRectGetMaxY(rect))

        let convertedTopLeft     = convertPoint(rect.origin)
        let convertedBottomRight = convertPoint(rectBottomRight)

        let convertedRectSize = CGSizeMake(
            abs(convertedBottomRight.x - convertedTopLeft.x),
            abs(convertedBottomRight.y - convertedTopLeft.y)
        )
        return CGRect(origin: convertedTopLeft, size: convertedRectSize)
    }
}
