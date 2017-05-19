//
//  YZQRMakeViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/5.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit
import CoreGraphics

class YZQRMakeViewController: UIViewController {

    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var qrImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    @IBAction @objc private func makeQR(_ sender: Any) {
        if textView.text.isEmpty {
            return
        }
        makeSystemQR(textView.text)
    }
    
    private func makeSystemQR(_ string: String) {
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        let data = string.data(using: .utf8, allowLossyConversion: true)
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        let outputImage = filter?.outputImage
        let image = createNonInterpolatedUIImage(outputImage!, size: qrImageView.width)
//        qrImageView.image = image
//        qrImageView.image = test(image, red: 0, green: 99, blue: 251)
        qrImageView.image = YZQRImageTool.imageBlack(toTransparent: image, withRed: 0, andGreen: 99, andBlue: 251)
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
    
//    func test(_ image: UIImage, red: CGFloat, green: CGFloat, blue: CGFloat) ->UIImage {
//        let imageW = Int(image.size.width)
//        let imageH = Int(image.size.height)
//        let bytesPerRow = imageW * 4
//        let rgbImageBuf = UnsafeMutablePointer<UInt>.allocate(capacity: bytesPerRow * imageH)
//        
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let context = CGContext(data: rgbImageBuf, width: imageW, height: imageH, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.noneSkipLast.rawValue)
//        context?.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: imageW, height: imageH))
//        /// 遍历像素
//        let pixelNum = imageW * imageH
//        var pCurPtr = rgbImageBuf
//        for _ in 0..<pixelNum {
//            if (pCurPtr.pointee & 0xFFFFFF00) < 0x99999900 {
//                let ptr = unsafeBitCast(pCurPtr, to: UnsafeMutablePointer<CUnsignedChar>.self)
////                let ptr = unsafeBitCast(pCurPtr, to: UnsafeMutablePointer<CUnsignedChar>.self)
//                ptr[3] = CUnsignedChar(red)
//                ptr[2] = CUnsignedChar(green)
//                ptr[1] = CUnsignedChar(blue)
//            }else{
//                let ptr = unsafeBitCast(pCurPtr, to: UnsafeMutablePointer<CUnsignedChar>.self)
//                ptr[0] = 0
//            }
//            pCurPtr += 1
//        }
//        let dataProvider = CGDataProvider.init(dataInfo: nil, data: rgbImageBuf, size: bytesPerRow * imageH, releaseData: ProviderReleaseDataCallback)
//        ///8195
//        let imageRef = CGImage(width: imageW, height: imageH, bitsPerComponent: 8, bitsPerPixel: 32, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little, provider: dataProvider!, decode: nil, shouldInterpolate: true, intent:  CGColorRenderingIntent.defaultIntent)
//
//        //CGDataProviderRelease(dataProvider)
//        let resultImage = UIImage(cgImage: imageRef!)
//        return resultImage
//    }
    
    let ProviderReleaseDataCallback: @convention(c) (UnsafeMutableRawPointer?, UnsafeRawPointer, Int) ->Void = {(info, data, size) ->Void in
        let ptr = UnsafeMutableRawPointer(mutating: data)
//        let ptr = unsafeBitCast(data, to: UnsafeMutableRawPointer.self)
        free(ptr)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }

}
