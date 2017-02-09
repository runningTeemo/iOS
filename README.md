# iOSswiftWebView 是webview和js进行交互， 在viewController里面有这个方法
func webView(_ webView: UIWebView!, didCreateJavaScriptContext ctx: JSContext!) {
        
        Tools.setupContext(ctx, forKey: "shaliwa") { t in
            print(t)
            self.tapAction()
            //self.navigationController?.pushViewController(TestViewController(), animated: true)
        }
    }
    
    shaliwa是方法名 后台可以直接调用shaliwa这个方法
