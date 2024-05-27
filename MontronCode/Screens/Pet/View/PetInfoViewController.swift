//
//  PetInfoViewController.swift
//  MontronCode
//
//  Created by Rashika Dube on 27/05/24.
//

import UIKit
import WebKit

class PetInfoViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var targetURLString: String?
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            webView.navigationDelegate = self
            loadWebViewRequest()
        }

        private func loadWebViewRequest() {
            guard let url = URL(string: targetURLString ?? "") else {
                print("URL is nil")
                return
            }
            
            let request = URLRequest(url: url)
            webView.load(request)
            activityIndicator.startAnimating()
        }

        // MARK: - WKNavigationDelegate

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
