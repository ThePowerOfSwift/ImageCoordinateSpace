# Image Coordinate Space
`UICoordinateSpace` for `UIImageView` image written in [Swift 2](https://developer.apple.com/swift/)

[![Build Status](https://travis-ci.org/paulz/ImageCoordinateSpace.svg?branch=master)](https://travis-ci.org/paulz/ImageCoordinateSpace)
[![Version](https://img.shields.io/cocoapods/v/ImageCoordinateSpace.svg?style=flat)](http://cocoapods.org/pods/ImageCoordinateSpace)
[![License](https://img.shields.io/cocoapods/l/ImageCoordinateSpace.svg?style=flat)](http://cocoapods.org/pods/ImageCoordinateSpace)
[![Platform](https://img.shields.io/cocoapods/p/ImageCoordinateSpace.svg?style=flat)](http://cocoapods.org/pods/ImageCoordinateSpace)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Usage

Convert `CGPoint` from image coordinates to view coordinates:


```swift
import ImageCoordinateSpace

let imageSpace = imageView.imageCoordinateSpace
let imageTopLeft = imageSpace.convertPoint(CGPointZero, toCoordinateSpace: imageView)
```

Convert `CGPoint` from view coordinates to image coordinates:


```swift
let viewTopLeft = imageSpace.convertPoint(CGPointZero, fromCoordinateSpace: imageView)
```


## Examples

### Add positioned image overlay
Open included Xcode Example project to see Xcode Playground: [Example/Visual.playground](Example/Visual.playground)

### Converting image face detection regions to view touch points
[http://stackoverflow.com/questions/12201603/translating-cidetector-face-detection-results-into-uiimageview-coordinates](http://stackoverflow.com/questions/12201603/translating-cidetector-face-detection-results-into-uiimageview-coordinates)
[http://stackoverflow.com/questions/33198266/convert-from-cirectanglefeature-coordinates-to-view-coordinates](http://stackoverflow.com/questions/33198266/convert-from-cirectanglefeature-coordinates-to-view-coordinates)

###Other uses from popular Stackoverflow questions:
 - Show image popover:
[http://stackoverflow.com/questions/15968251/get-the-zoomed-coordinates-of-an-image](http://stackoverflow.com/questions/15968251/get-the-zoomed-coordinates-of-an-image)
 - Reposition image:
[http://stackoverflow.com/questions/16733419/how-to-get-uiimage-coordinates-x-y-width-height-in-uiimageview-in-xcode](http://stackoverflow.com/questions/16733419/how-to-get-uiimage-coordinates-x-y-width-height-in-uiimageview-in-xcode)
 - Add touch events to image:
[http://stackoverflow.com/questions/17200191/converting-uiimageview-touch-coordinates-to-uiimage-coordinates](http://stackoverflow.com/questions/17200191/converting-uiimageview-touch-coordinates-to-uiimage-coordinates)
 - Implement pan and zoom for the image:
[http://stackoverflow.com/questions/1813432/how-to-determine-image-coordinates-for-a-large-cropped-image-within-a-uiimagevie](http://stackoverflow.com/questions/1813432/how-to-determine-image-coordinates-for-a-large-cropped-image-within-a-uiimagevie)

![Sample image](Example/Visual.playground/Resources/rose.jpg)

## Documentation

HeaderDoc is included, see [UIImageView+UICoordinateSpace.swift](ImageCoordinateSpace/UIImageView%2BUICoordinateSpace.swift)

## Installation

ImageCoordinateSpace is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ImageCoordinateSpace'
```

## Unit tests

To run included unit tests install dependencies via carthage:

```sh
carthage bootstrap
```

Run tests:

```sh
xctool test
```

## Author

Paul Zabelin, [https://github.com/paulz](https://github.com/paulz)

## License

ImageCoordinateSpace is available under the MIT license. See the LICENSE file for more info.
