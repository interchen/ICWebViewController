# ICWebViewController [中文介绍](https://github.com/interchen/ICWebViewController/blob/master/README_CN.md)

A simple UIViewController contains a WKWebView and UIProgressView written by Swift 3.  


Maybe you'll say "Why don't you use SafariViewController".  
Right! If you just want to display a webview.  
But if you want to deal with cookie or some interact with javascript, you can try this lib.  

## Install
`pod 'ICWebViewController'`  


## ICWebViewController
- WKWebView
- Use `document.title` as title of navigation bar
- Show load progress
- Screen edge pan gesture to go back

![ICWebViewController](https://github.com/interchen/ICWebViewController/blob/master/ScreenShots/ICWebViewController.png)

## ICWXWebViewController
- Base on `ICWebViewController`
- Custom left bar buttons, provide a "back button" to go back and a "close  button" to dismiss viewController

![ICWXWebViewController](https://github.com/interchen/ICWebViewController/blob/master/ScreenShots/ICWXWebViewController.png)
