//
//  WebViewController.swift
//  Sample
//
//  Created by Samarth Paboowal on 01/02/18.
//  Copyright © 2018 Samarth Paboowal. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    //MARK: - Variables
    
    var data = FoodCollection()
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var webView: UIWebView!
    let progressBar = ProgressBar(text: "Loading....")
    
    
    //MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        webView.loadRequest(URLRequest(url: URL(string: data.url!)!))
    }
    
    
    //MARK: - Web View Delegate Methods
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        webView.addSubview(progressBar)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        progressBar.hide()
    }

}
