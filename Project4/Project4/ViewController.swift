//
//  ViewController.swift
//  Project4
//
//  Created by Frank Chu on 1/5/23.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    static var websites = ["apple.com", "hackingwithswift.com", "about:blank"]
    var selectedWebsiteIndex = 0
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        
        /**
         Summary
         The view that the controller manages.
        
         Declaration
         var view: UIView! { get set }
         */
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let url = URL(string: "https://" + ViewController.websites[self.selectedWebsiteIndex]) {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil
        )
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(
            customView: progressView
        )
        
        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let reload = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: webView,
            action: #selector(webView.reload)
        )
        
        let goBack = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        let goForward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        
        toolbarItems = [goBack, goForward, spacer, progressButton, spacer, reload]
        navigationController?.isToolbarHidden = false
    }
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    )
    {
        if let url = navigationAction.request.url {
            if let host = url.host {
                for website in ViewController.websites {
                    if host.contains(website) {
                        decisionHandler(.allow)
                        return
                    }
                }
            }
        }
        
        decisionHandler(.cancel)
        if let url = navigationAction.request.url {
            let alertController = UIAlertController(title: "Censored", message: "This website is blocked. \(String(describing: url))", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//
//        // You met Key-Value Observing, or KVO, which we used to update the loading progress in our web browser.
//        // This lets you monitor any property in all of iOS and be notified when it changes.
//        if keyPath == "estimatedProgress" {
//            progressView.progress = Float(webView.estimatedProgress)
//        }
//    }
    
    @objc func openTapped() {
        let alertController = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        // <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>
        
        for website in ViewController.websites {
            alertController.addAction(
                UIAlertAction(
                    title: website,
                    style: .default,
                    handler: openPage(action:)
                )
            )
        }
        
        alertController.addAction(
            UIAlertAction(
                title: "add your website",
                style: .default,
                handler: customWebSite(action:)
            )
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
        )
        
        alertController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        present(alertController, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        if let title = action.title {
            if let url = URL(string: "https://" + title) {
                self.webView.load(URLRequest(url: url))
            }
        }
    }
    
    func customWebSite(action: UIAlertAction) {
        let alertController = UIAlertController(title: "Website", message: "Enter your Website", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Website"
        }
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { alertAction in
            if let website = alertController.textFields?.first?.text {
                if let url = URL(string: "https://" + website) {
                    self.webView.load(URLRequest(url: url))
                }
            }
        }))
        
        present(alertController, animated: true)
    }

}

