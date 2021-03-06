# ICWebViewController [English Version](https://github.com/interchen/ICWebViewController/blob/master/README.md)

这是一个封装了 WKWebView 和 UIProgressView 的 UIViewController。  
使用 Swift 3 编写  

有人说为什么不直接使用 SafariViewController？  
是的，如果你仅是为了展示一个网页，那 SafariViewController 是最好的选择  
但是如果还需要在 webView 上处理 cookie 或与 javascript 交互的话，那可以尝试一下

## 安装
`pod 'ICWebViewController'`

## ICWebViewController
- WKWebView
- 使用 `document.title` 作为 navigation bar 的标题
- 显示加载进度
- 支持屏幕边缘滑动操作

![ICWebViewController](https://github.com/interchen/ICWebViewController/blob/master/ScreenShots/ICWebViewController.png)

## ICWXWebViewController
- 继承于 `ICWebViewController`
- 自定义左上角的导航按钮，提供“返回”按钮用于网页的回退，提供“关闭”按钮用于退出当前控制器

![ICWXWebViewController](https://github.com/interchen/ICWebViewController/blob/master/ScreenShots/ICWXWebViewController.png)
