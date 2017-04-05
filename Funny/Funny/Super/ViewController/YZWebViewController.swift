//
//  YZWebViewController.swift
//  Funny
//
//  Created by yanzhen on 16/12/29.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet private weak var webView: UIWebView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    private var urlStr: String = ""
    
    init(urlString: String) {
        super.init(nibName: "YZWebViewController", bundle: nil)
        self.hidesBottomBarWhenPushed = true
        urlStr = urlString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Y&Z"
        let request = URLRequest(url: NSURL(string: urlStr)! as URL)
        webView.loadRequest(request)
    }
    
    public func jsString() ->String {
        return ""
    }
    
    private func showWebView() {
        indicator.stopAnimating()
        webView.isHidden = false
    }
//MARK: UIWebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.stringByEvaluatingJavaScript(from: jsString())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showWebView()
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        showWebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
