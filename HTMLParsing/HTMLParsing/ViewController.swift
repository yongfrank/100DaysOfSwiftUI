//
//  ViewController.swift
//  HTMLParsing
//
//  Created by Frank Chu on 7/18/22.
//  Parse HTML in Swift 5 (HTMLKit) - Xcode 11, 2020, iOS Development
//  https://www.youtube.com/watch?v=biG7RnRR9Pg

import UIKit
import HTMLKit
import WebKit

class ViewController: UIViewController {
    
    private let webView: WKWebView = {
//        let prefs = WKPreferences()
//        prefs.javaScriptEnabled = true
//        let prefs = WKWebpagePreferences()
//        prefs.allowsContentJavaScript = true
        
        let config = WKWebViewConfiguration()
//        config.preferences = prefs
        
        let webView = WKWebView(frame: .zero, configuration: config)
        
        
        let webView = WKWebView(frame: .zero)
        return webView
    }()

    
    let url = "https://www.google.com/search?q=captain+america&tbm=isch&ved=2ahUKEwj2i-C2i4L5AhWljtgFHaViB6wQ2-cCegQIABAA&oq=captain+america&gs_lcp=CgNpbWcQAzIECCMQJzIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDoECAAQQ1DmB1jmB2DtCmgAcAB4AIABngKIAfgDkgEDMi0ymAEAoAEBqgELZ3dzLXdpei1pbWfAAQE&sclient=img&ei=GSPVYrabL6Wd4t4PpcWd4Ao&bih=1206&biw=2056"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.frame = view.bounds
        webView.navigationDelegate = self
        
        guard let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
    }


}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // parsing
        parseImages()
    }
    
    func parseImages() {
        webView.evaluateJavaScript("document.body.innerHTML") { result, error in
            guard let html = result as? String, error == nil else { return }
            
            
            let document = HTMLDocument(string: html)
            let images: [String] = document.querySelectorAll("img").compactMap { htmlElement in
                guard let src = htmlElement.attributes["src"] as? String else { return nil }
                return src
            }
            for image in images {
                print("DEBUG: \(image)")
            }
        }

    }
}

