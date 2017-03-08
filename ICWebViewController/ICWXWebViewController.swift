//
//  ICWXWebViewController.swift
//  ICWebViewController
//
//  Created by 陈 颜俊 on 2017/3/3.
//  Copyright © 2017年 azhunchen. All rights reserved.
//

import UIKit
import WebKit

class ICWXWebViewController: ICWebViewController, WKNavigationDelegate, UIGestureRecognizerDelegate {

    open var backButtonTitle: String!
    open var closeButtonTitle: String!
    
    fileprivate var isPresent = false
    fileprivate var closeBarButton: UIBarButtonItem!
    fileprivate var backBarButton: UIBarButtonItem!
    
    deinit {
        self.webView.navigationDelegate = nil
    }
    
    convenience init(_ url: URL) {
        self.init()
        self.url = url
        self.backButtonTitle = "返回"
        self.closeButtonTitle = "关闭"
    }
    
    convenience init(_ url: URL, backButtonTitle: String?, closeButtonTitle: String?) {
        self.init()
        self.url = url
        self.backButtonTitle = backButtonTitle ?? "返回"
        self.closeButtonTitle = closeButtonTitle ?? "关闭"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.navigationDelegate = self
        self.setupBarButtons()
        
        self.isPresent = self.presentingViewController != nil
        if isPresent {
            self.navigationItem.leftBarButtonItems = [self.closeBarButton]
        } else {
            self.navigationItem.leftBarButtonItems = [self.backBarButton]
        }
    }
    
    weak var originalGestureDelegate: UIGestureRecognizerDelegate?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.originalGestureDelegate = self.navigationController?.interactivePopGestureRecognizer?.delegate
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self.originalGestureDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI
    
    fileprivate func setupBarButtons() {
        let closeButton = UIButton(type: .system)
        closeButton.setTitle(self.closeButtonTitle, for: .normal)
        closeButton.setTitleColor(self.navigationController?.navigationBar.tintColor, for: .normal)
        closeButton.tintColor = self.navigationController?.navigationBar.tintColor
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        closeButton.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        closeButton.sizeToFit()
        closeButton.contentEdgeInsets = UIEdgeInsetsMake(1, -10, 0, 0)
        self.closeBarButton = UIBarButtonItem(customView: closeButton)
        
        let backButton = UIButton(type: .system)
        backButton.setTitle(self.backButtonTitle, for: .normal)
        backButton.setTitleColor(self.navigationController?.navigationBar.tintColor, for: .normal)
        backButton.tintColor = self.navigationController?.navigationBar.tintColor
        backButton.setImage(UIImage(named: "icon_back"), for: .normal)
        backButton.setImage(UIImage(named: "icon_back"), for: .highlighted)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        backButton.sizeToFit()
        backButton.contentEdgeInsets = UIEdgeInsetsMake(2, -15, 0, 0)
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0)
        self.backBarButton = UIBarButtonItem(customView: backButton)
    }
    
    // MARK: - Action
    
    func handleClose() {
        if isPresent {
            self.dismiss(animated: true, completion: nil)
        } else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func handleBack() {
        if self.webView.canGoBack {
            //网页返回
            self.webView.goBack()
        } else {
            //原生导航返回
            self.handleClose()
        }
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        decisionHandler(.allow)
        updateBackButtons(navigationAction)
    }
    
    func updateBackButtons(_ navigationAction: WKNavigationAction) {
        switch navigationAction.navigationType {
        case .backForward:
            if isPresent, !self.webView.canGoBack {
                self.navigationItem.leftBarButtonItems = [self.closeBarButton]
            } else {
                if self.navigationItem.leftBarButtonItems?.count != 2 {
                    self.navigationItem.leftBarButtonItems = [self.backBarButton, self.closeBarButton]
                }
            }
            
        default:
            break
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIScreenEdgePanGestureRecognizer, !self.webView.canGoBack {
            return true
        }
        return false
    }

}
