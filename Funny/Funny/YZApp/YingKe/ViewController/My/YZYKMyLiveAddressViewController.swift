//
//  YZYKMyLiveAddressViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZYKMyLiveAddressViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "扫一扫看我直播"
        self.view.backgroundColor = UIColor.white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 220, height: 220))
        imageView.center = self.view.center
        imageView.image = makeSelfLiveAddressQR(YZUserDefaultsManager.getSelfLiveAddress(), size: imageView.width)
        self.view.addSubview(imageView)
    }

    private func makeSelfLiveAddressQR(_ address: String, size: CGFloat) ->UIImage {
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        let data = address.data(using: .utf8, allowLossyConversion: true)
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        let outputImage = filter?.outputImage
        let image = createNonInterpolatedUIImage(outputImage!, size: size)
        return YZQRImageTool.imageBlack(toTransparent: image, withRed: 0, andGreen: 99, andBlue: 251)
    }
    
    private func createNonInterpolatedUIImage(_ image: CIImage, size: CGFloat) ->UIImage {
        let extent = image.extent.integral
        let scale = min(size / extent.width, size / extent.height)
        let width  = extent.width * scale
        let height = extent.height * scale
        
        let cs = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.none.rawValue)//kCGImageAlphaNone
        let context = CIContext(options: nil)
        let bitmapImage = context.createCGImage(image, from: extent)
        bitmapRef?.interpolationQuality = .none
        bitmapRef?.scaleBy(x: scale, y: scale)
        bitmapRef?.draw(bitmapImage!, in: extent)
        let scaleImage = bitmapRef?.makeImage()
        return UIImage(cgImage: scaleImage!)
    }

}
