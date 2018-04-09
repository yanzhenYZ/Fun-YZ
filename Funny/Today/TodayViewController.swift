//
//  TodayViewController.swift
//  Today
//
//  Created by yanzhen on 17/1/12.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit
import NotificationCenter
import YZIPhoneDevice

class TodayViewController: UIViewController, NCWidgetProviding {
    
    private var timer: Timer!
    private var network: YZNetwork!
    private var cpu: YZCPU!
    
    deinit {
        timer.invalidate()
        cpu.stopMonitorCPUUsage()
        network.stopMonitorNetWork()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        let titles = ["快手","笔记","二维码","自拍"]
        let images = [#imageLiteral(resourceName: "gifShow"),#imageLiteral(resourceName: "note"),#imageLiteral(resourceName: "QR"),#imageLiteral(resourceName: "meipai")]
        let tags = [101,901,902,903]
        
        let space: CGFloat = 10
        let maximumSize = self.extensionContext?.widgetMaximumSize(for: .expanded)
        let btnWidth = (maximumSize!.width - 5.0 * space) / 4
        let btnHeight = maximumSize!.height - 20.0;
        for i in 0...3 {
            let btn = YZTodayButton(frame: CGRect(x: space + (btnWidth + space) * CGFloat(i), y: 10, width: btnWidth, height: btnHeight))
            btn.tag = tags[i]
            btn.setImage(images[i], for: .normal)
            btn.setTitle(titles[i], for: .normal)
            btn.addTarget(self, action: #selector(self.extensionButtonAction(btn:)), for: .touchUpInside)
            self.view.addSubview(btn)
        }
        ///
        let circleWH: CGFloat = 90
        let radius = (circleWH - 5) / 2
        let bottomSpace = (maximumSize!.width - circleWH * 3) / 4
        var x1 = bottomSpace
        
        let cpuView = YZTodayCircleView(frame: CGRect(x: x1, y: 120, width: circleWH, height: circleWH), radius: radius, title: "CPU", titleFontSize: 14, subTitle: "", subTitleFontSize: 15)
        self.view.addSubview(cpuView)
        cpu = YZCPU()
        cpu.startMonitorCPUUsage(withTimeInterval: 1.0) { (usage) in
            let subTitle = String(format: "%.1f", usage * 100) + "%"
            cpuView.setProgress(usage, subTitle: subTitle)
        }
        
        x1 = bottomSpace + (bottomSpace + circleWH)
        let memoryView = YZTodayCircleView(frame: CGRect(x: x1, y: 120, width: circleWH, height: circleWH), radius: radius, title: "空间剩余", titleFontSize: 13, subTitle: "", subTitleFontSize: 13)
        self.view.addSubview(memoryView)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            let availableSize = YZDevice.getAvailableDiskSize()
            let totalSize = YZDevice.getTotalDiskSize()
            let subTitle = String(format: "%.1fG/%.1fG", CGFloat(availableSize) / 1024.0 / 1024 / 1024,CGFloat(totalSize) / 1024.0 / 1024 / 1024)
            memoryView.setProgress(1 - CGFloat(availableSize) / CGFloat(totalSize), subTitle: subTitle)
        })
        
        x1 = bottomSpace + (bottomSpace + circleWH) * 2
        let netWorkView = YZTodayCircleView(frame: CGRect(x: x1, y: 120, width: circleWH, height: circleWH), radius: radius, title: "无网络", titleFontSize: 14, subTitle: "", subTitleFontSize: 15)
        self.view.addSubview(netWorkView)
        network = YZNetwork()
        network.getCurrentNetSpeed { [weak self] (netWorkFlux) in
            let titles = ["无网络","Wifi","4G","3G","2G"]
            netWorkView.setTitle(titles[Int(netWorkFlux!.netStatus.rawValue)])
            netWorkView.setProgress(0, subTitle: self?.stringFromBytes(received: netWorkFlux!.received))
        }
    }
    
    @objc private func extensionButtonAction(btn: YZTodayButton) {
        let url = NSURL(string: "YZFunny://" + String(btn.tag));
        self.extensionContext?.open(url as URL!, completionHandler: nil);
    }

    private func stringFromBytes(received: Float) ->String {
        let KB: Float = 1024.0;
        let MB = KB * 1024;
        let GB = MB * 1024;
        var speed = "0B/s";
        
        if received >= GB {
            speed = String(format: "%.1fG/s", received / GB);
        }else if received >= MB {
            speed = String(format: "%.1fM/s", received / MB);
        }else if received >= KB {
            speed = String(format: "%.1fKB/s", received / KB);
        }else{
            speed = String(format: "%.0fB/s", received);
        }
        return speed;
    }
//MARK: - NCWidgetProviding
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let height: CGFloat = activeDisplayMode == .compact ? 110 : 220
        self.preferredContentSize = CGSize(width: 0, height: height)
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
