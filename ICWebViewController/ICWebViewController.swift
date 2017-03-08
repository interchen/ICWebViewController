//
//  ICWebViewController.swift
//  ICWebViewController
//
//  Created by azhunchen on 2017/3/3.
//  Copyright © 2017年 azhunchen. All rights reserved.
//

import UIKit
import WebKit

open class ICWebViewController: UIViewController {
    
    let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    let progressView = UIProgressView()
    open var url: URL?
    
    // MARK: Life cycle
    public convenience init(_ url: URL) {
        self.init()
        self.url = url
    }
    
    deinit {
        if self.isViewLoaded {
            self.webView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
            self.webView.removeObserver(self, forKeyPath: "title", context: nil)
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        
        self.loadRequest()
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.progressView.frame = CGRect(x: 0, y: 0 - self.webView.scrollView.bounds.origin.y, width: self.webView.bounds.size.width, height: 2.0)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initUI() {
        self.view.backgroundColor = .white
        
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView.addSubview(self.progressView)
        self.view.addSubview(self.webView)
        
        // webView constraints
        let views: [String : Any] = ["webView" : self.webView,
                                     "topLayoutGuide" : self.topLayoutGuide]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[webView]-0-|", options: [], metrics: nil, views: views)
        var vvf = "V:[topLayoutGuide]-0-[webView]-0-|"
        if self.navigationController != nil {
            vvf = "V:|-0-[webView]-0-|"
        }
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: vvf, options: [], metrics: nil, views: views)
        self.view.addConstraints(hConstraints)
        self.view.addConstraints(vConstraints)
        
        self.webView.allowsBackForwardNavigationGestures = true
        self.progressView.progress = 0.1 // to fix short time blank when view did load
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath {
            switch keyPath {
            case "estimatedProgress":
                let newProgress = change![.newKey] as! Float
                switch newProgress {
                case 0.0:
                    self.progressView.isHidden = false
                    
                case 1.0:
                    self.progressView.progress = newProgress
                    delay(0.5, closure: {
                        UIView.animate(withDuration: 0.2, animations: {
                            self.progressView.isHidden = true
                        })
                    })
                    
                default:
                    self.progressView.progress = newProgress
                    self.progressView.isHidden = false
                }
                
            case "title":
                let title = change![.newKey] as! String
                self.title = title
                
            default:
                break
            }
        }
    }
    
    // MARK: - private
    open func loadRequest() {
        if let url = self.url {
            let request = NSMutableURLRequest(url: url, cachePolicy:.useProtocolCachePolicy, timeoutInterval: 86400)
            
            // add request cookie here
            //            request.addValue("key=value;", forHTTPHeaderField: "Cookie")
            
            webView.load(request as URLRequest)
        }
    }
    
    func delay(_ delay:Double? = 1.0, closure:@escaping ()->Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay! * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure
        )
    }
}
