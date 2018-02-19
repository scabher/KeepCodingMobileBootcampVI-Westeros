//
//  WikiViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera on 15/02/2018.
//  Copyright © 2018 Sergio Cabrera. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {
    
    // Mark: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // Mark: - Properties
    let model: House
    
    // Mark: - Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    // chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false
        loadingView.startAnimating()
        webView.navigationDelegate = self
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        title = model.name
        webView.load(URLRequest(url: model.wikiURL))
    }
    
    // MARK: - UI Sin delegado
//    func setupUI() {
//        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
//
//        navigationItem.rightBarButtonItem = wikiButton
//    }
//
//    @objc func displayWiki() {
//        // Creamos el WikiVC
//        let wikiViewController = WikiViewController(model: model)
//
//        // Hacemos push
//        navigationController?.pushViewController(wikiViewController, animated: true)
//    }
}

extension WikiViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }

    // @escaping : Determina que la clausura (WKNavigationActionPolicy) -> Void es asíncrona
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        let type = navigationAction.navigationType
        switch type {
        case .linkActivated, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}















