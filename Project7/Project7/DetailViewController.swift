//
//  DetailViewController.swift
//  Project7
//
//  Created by Frank Chu on 1/20/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var petition: Petition?
    
    override func loadView() {
        self.webView = WKWebView()
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        guard let petition = petition else { return }
        
        // meta是html语言head区的一个辅助性标签。我对它的印象只停留在用移动端是加上
        // 来保证在移动端显示不用放大和缩小。这我也不知道对不对，先写下，以后查询修正一下，我怕我一查询就没有思路写下去了
        // https://developer.mozilla.org/en-US/docs/Web/HTML/Viewport_meta_tag
        let htmlString = """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body {
                    font-family: "Gill Sans", sans-serif;
                    /* Apply to all four sides */
                    padding: 1em;
                    background-color: cyan;
                }
                /* Style the title */
                  h1 {
                    
                  }
        
                  /* Style the content */
                  p {
                    
                  }
            </style>
        </head>
        
        <body>
            <h1>\(petition.title)</h1>
            <p>\(petition.body)</p>
        </body>
        
        </html>
        """
        self.webView.loadHTMLString(htmlString, baseURL: nil)
        //        self.webView.load(URLRequest(url: URL(string: "https://apple.com")!))
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
