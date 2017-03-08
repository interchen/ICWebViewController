//
//  ViewController.swift
//  ICWebViewController
//
//  Created by 陈 颜俊 on 2017/3/3.
//  Copyright © 2017年 azhunchen. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
    
    let url = URL(string: "http://www.jianshu.com/u/9a3e91ec4dcf")!
    
    @IBOutlet weak var controllerTypeSC: UISegmentedControl!
    @IBOutlet weak var showTypeSC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleStartButton(_ sender: Any) {
        var viewController: UIViewController!
        
        if controllerTypeSC.selectedSegmentIndex == 0 {
            viewController = ICWebViewController(url)
        } else {
            viewController = ICWXWebViewController(url)
        }
        
        if showTypeSC.selectedSegmentIndex == 0 {
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            self.navigationController?.present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
        }
    }
}

