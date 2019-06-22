# ZKCollectionViewFreezeLayout

[![Version](https://img.shields.io/cocoapods/v/ZKCollectionViewFreezeLayout.svg?style=flat)](http://cocoapods.org/pods/ZKCollectionViewFreezeLayout)
[![License](https://img.shields.io/cocoapods/l/ZKCollectionViewFreezeLayout.svg?style=flat)](http://cocoapods.org/pods/ZKCollectionViewFreezeLayout)
[![Platform](https://img.shields.io/cocoapods/p/ZKCollectionViewFreezeLayout.svg?style=flat)](http://cocoapods.org/pods/ZKCollectionViewFreezeLayout)

## Description

The ZKCollectionViewFreezeLayout extends UICollectionViewLayout. 

Support both `Horizontal` and `Vertical` scroll direct.

Can set `freeze` coloums numbers and rows numbers.



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

The example codes looks like.

```swift
let layout = ZKCollectionViewFreezeLayout()
layout.delegate = self
layout.freezeColum = 3
layout.freezeRow = 2
layout.itemSize = CGSize(width: 70, height: 70)
        
        
collectionView.setCollectionViewLayout(layout, animated: false)
collectionView.backgroundColor = UIColor.whiteColor()
collectionView.bounces = false
```

![Simple image](https://raw.githubusercontent.com/KevinZhouRafael/ZKCollectionViewFreezeLayout/master/collectionFreezeLayout.gif)

## Requirements
- iOS 8.0+
- Xcode 10.2
- Swift 5

## Installation

ZKCollectionViewFreezeLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZKCollectionViewFreezeLayout"
```

## Author

Rafael Zhou

- Email me: <wumingapie@gmail.com>
- Follow me on **Twitter**: [**@wumingapie**](https://twitter.com/wumingapie)
- Contact me on **Facebook**: [**wumingapie**](https://www.facebook.com/wumingapie)
- Contact me on **LinkedIn**: [**Rafael**](https://www.linkedin.com/in/rafael-zhou-7230943a/)

## License

ZKCollectionViewFreezeLayout is available under the MIT license. See the LICENSE file for more info.
