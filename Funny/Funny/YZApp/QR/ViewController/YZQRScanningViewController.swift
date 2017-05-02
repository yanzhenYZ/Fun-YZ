//
//  YZQRScanningViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/5.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit
import AVFoundation

class YZQRScanningViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate,  UIImagePickerControllerDelegate {

    public var scanVC: YZQRScanViewController!
    private var is3DTouch: Bool = false
    private var isLive: Bool = false
    private var session: AVCaptureSession?
    
    @IBOutlet weak var imageView: UIImageView!
    init(touch3D: Bool) {
        super.init(nibName: "YZQRScanningViewController", bundle: nil)
        is3DTouch = touch3D
    }
    
    init(live: Bool) {
        super.init(nibName: "YZQRScanningViewController", bundle: nil)
        isLive = live
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        startScanning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(self.maskLayer)
        let scanWH: CGFloat = 300
        let scanNetIV = UIImageView(frame: CGRect(x: 0, y: -scanWH, width: scanWH, height: scanWH))
        scanNetIV.image = #imageLiteral(resourceName: "scan_net")
        ///
        let scanNetAnimation = CABasicAnimation()
        scanNetAnimation.keyPath = "transform.translation.y"
        scanNetAnimation.byValue = scanWH
        scanNetAnimation.duration = 1.0
        scanNetAnimation.repeatCount = MAXFLOAT
        scanNetAnimation.fillMode = kCAFillModeForwards
        scanNetAnimation.isRemovedOnCompletion = false
        scanNetIV.layer.add(scanNetAnimation, forKey: nil)
        imageView.addSubview(scanNetIV)
        
    }

    private func startScanning() {
        if session~~ {
            return
        }
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let input = try! AVCaptureDeviceInput(device: device!)
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        ///限制扫描区域
        ///http://www.jianshu.com/p/4772d3cb6a43
        let scanWH: CGFloat = 300
        let scanX = (HEIGHT - scanWH) / 2 / HEIGHT
        let scanY = (WIDTH - scanWH) / 2 / WIDTH
        output.rectOfInterest = CGRect(x: scanX, y: scanY, width: scanWH / HEIGHT + scanX, height: scanWH / WIDTH + scanY)
        ///
        session = AVCaptureSession()
        session?.sessionPreset = AVCaptureSessionPresetHigh
        if session!.canAddInput(input) {
            session?.addInput(input)
        }
        if session!.canAddOutput(output) {
            session?.addOutput(output)
        }
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        let previewLayer = AVCaptureVideoPreviewLayer(session: session!)
        previewLayer?.frame = CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        view.layer.insertSublayer(previewLayer!, at: 0)
        session?.startRunning()
    }
//MARK: - UIImagePickerController
    @IBAction private func scanPhoto(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.delegate = self
        self.present(imagePicker, animated: true) { 
            MBProgressHUD.showMessage("正在识别", to: self.view)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.dismiss(animated: true) { 
            self.readQR(image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        MBProgressHUD.hide(for: view)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func readQR(_ image: UIImage) {
        ///image.ciImage不能截取结果？？？
//        let ciImage = image.ciImage
        let ciImage = CIImage(cgImage: image.cgImage!)
        let context = CIContext(options: [kCIContextUseSoftwareRenderer : NSNumber(value: true)])
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        MBProgressHUD.hide(for: self.view, animated: true)
        
        let features = detector?.features(in: ciImage)
        if features~~ && features!.count > 0 {
            for (_,value) in features!.enumerated() {
                if value is CIQRCodeFeature {
                    let feature = value as! CIQRCodeFeature
                    scanningDone(feature.messageString!)
                    return
                }
            }
        }
        let alert = UIAlertController(title: "提示", message: "无法识别您选中的图片", preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
//MARK: - AVCaptureMetadataOutputObjectsDelegate
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects.count > 0 {
            let obj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            scanningDone(obj.stringValue)
        }
    }
    
    private func scanningDone(_ value: String) {
        if is3DTouch {
            touch3DScanningDone(value)
        }else if isLive {
            session?.stopRunning()
            liveScanningDone(value)
        }else{
            scanVC.scanningDone(value)
            session?.stopRunning()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func liveScanningDone(_ value: String) {
        let model = YZYingKeModel()
        ///model.stream_addr = [NSString stringWithFormat:YK_Live_Header,@"1481618515_4EFB6FC4-617E-48FB-B93F-F561795125EC"]
        model.stream_addr = YK_Live_Header + value
        let alert = UIAlertController(title: "扫描结果", message: value, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "输入好友的名字"
        }
        
        let saveAction = UIAlertAction(title: "保存", style: .destructive) { (action) in
            let live = YZYKDBModel()
            live.name = alert.textFields!.first!.text!.isEmpty ? "好友" : alert.textFields!.first?.text
            live.liveAddress = value
            YZNoteManager.manager.addLive(live)
        }
        
        unowned let blockSelf = self
        let liveAction = UIAlertAction(title: "看直播", style: .default) { (action) in
            let live = YZYKDBModel()
            live.name = alert.textFields!.first!.text!.isEmpty ? "好友" : alert.textFields!.first?.text
            live.liveAddress = value
            YZNoteManager.manager.addLive(live)
            ///---
            let player = YZYKPlayerViewController(model)
            blockSelf.navigationController?.pushViewController(player, animated: true)
        }
        alert.addAction(liveAction)
        alert.addAction(saveAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func touch3DScanningDone(_ value: String) {
        let alert = UIAlertController(title: "扫描结果", message: value, preferredStyle: .alert)
        if value.isURL {
            let action = UIAlertAction(title: "打开网址", style: .destructive, handler: { (action) in
                UIApplication.shared.open(URL(string: value)!, options: [:], completionHandler: nil)
            })
            alert.addAction(action)
        }
        let sureAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(sureAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction private func exit(_ sender: Any) {
        if isLive {
            self.navigationController?.popViewController(animated: true)
        }else{
           self.dismiss(animated: true, completion: nil)
        }
    }
   
    
//MARK: - maskLayer
    private lazy var maskLayer: CAShapeLayer = {
        let layer = self.creatMaskLayer(exceptRect: CGRect(x: (WIDTH - 300) * 0.5, y: (HEIGHT - 300) * 0.5, width: 300, height: 300))
        layer.fillColor = UIColor(white: 0, alpha: 0.5).cgColor
        return layer
    }()
    
    private func creatMaskLayer(exceptRect: CGRect) ->CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        let exceptX = exceptRect.origin.x
        let exceptY = exceptRect.origin.y
        let exceptW = exceptRect.size.width
        let exceptH = exceptRect.size.height
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: WIDTH, height: exceptY))
        path.append(UIBezierPath(rect: CGRect(x: 0, y: exceptY, width: exceptX, height: exceptH)))
        path.append(UIBezierPath(rect: CGRect(x: 0, y: exceptY + exceptH, width: WIDTH, height: exceptY)))
        path.append(UIBezierPath(rect: CGRect(x: exceptX + exceptW, y: exceptY, width: exceptX, height: exceptH)))
        shapeLayer.path = path.cgPath
        return shapeLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
