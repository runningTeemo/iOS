//
//  ViewController.swift
//  SwiftWebView
//
//  Created by zerlinda on 2016/10/31.
//  Copyright © 2016年 zerlinda. All rights reserved.
//

import UIKit
import JavaScriptCore

//protocol JS_TSViewController {
  //  func text(str:String)->String?
//}
typealias MyClosure = ()->()

class ViewController: UIViewController,UIWebViewDelegate,TSWebViewDelegate {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let tc = Test()
        tc.testPrint()
        let webView = UIWebView()
        webView.frame = self.view.frame
        webView.backgroundColor = UIColor.red
        webView.delegate = self
        webView.scalesPageToFit = true
        webView.loadRequest(URLRequest(url: URL(string: "http://192.168.1.19:8089/cv_api/ui/page/news/detail.html?id=304348&type=news")!))
        self.view.addSubview(webView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }

    func webView(_ webView: UIWebView!, didCreateJavaScriptContext ctx: JSContext!) {
        
        Tools.setupContext(ctx, forKey: "shaliwa") { t in
            print(t)
            self.tapAction()
            //self.navigationController?.pushViewController(TestViewController(), animated: true)
        }
    }
    func tapAction(){
        
        print("后端调用了前端的方法")
    }
    
    func viewController(str:String){
        print(str)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

