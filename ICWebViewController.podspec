
Pod::Spec.new do |s|

  s.name         = "ICWebViewController"
  s.version      = "0.0.1"
  s.summary      = "A simple UIViewController contains a WKWebView"
  s.description  = 'Support show title of webview and progress of loading'
  
  s.homepage     = "https://github.com/interchen/ICWebViewController"

  s.license      = 'MIT'

  s.author             = { "Chen Yanjun" => "inter.chen@gmail.com" }
  s.social_media_url   = "https://twitter.com/azhunchen"

  s.ios.deployment_target  = '8.0'

  s.source       = { :git => "https://github.com/interchen/ICWebViewController.git", :tag => s.version }
  s.source_files  = 'ICWebViewController/IC*.swift'
  s.resources = 'ICWebViewController/*.png'
 
  s.requires_arc = true
  
end
