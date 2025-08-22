//
//  WebViewController.swift
//  MiniAppOtherServices
//
//  Created by Universe on 20/8/25.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    private var webView: WKWebView!
    private var url: URL
    private var serviceName: String
    
    private var progressView: UIProgressView!

    init(url: URL, serviceName: String) {
        self.url = url
        self.serviceName = serviceName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupNavigationBar()
        setupWebView()
        setupProgressView()
        
        webView.load(URLRequest(url: url))
    }

    private func setupNavigationBar() {
        let backButton = UIButton(type: .system)
        let backImage = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)

        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 18),
            backButton.heightAnchor.constraint(equalToConstant: 18)
        ])

        let titleLabel = UILabel()
        titleLabel.text = serviceName
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .label

        let leftStack = UIStackView(arrangedSubviews: [backButton, titleLabel])
        leftStack.axis = .horizontal
        leftStack.spacing = 8
        leftStack.alignment = .center

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftStack)
        
        let closeButton = UIButton(type: .system)
            let closeImage = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal)
            closeButton.setImage(closeImage, for: .normal)
            closeButton.addTarget(self, action: #selector(didDimiss), for: .touchUpInside)
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                closeButton.widthAnchor.constraint(equalToConstant: 14),
                closeButton.heightAnchor.constraint(equalToConstant: 14)
            ])

            let container = UIView()
            container.addSubview(closeButton)
            container.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                closeButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
                closeButton.topAnchor.constraint(equalTo: container.topAnchor),
                closeButton.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor)
            ])

            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: container)
    }


    private func setupWebView() {
        webView = WKWebView(frame: .zero)
        webView.navigationDelegate = self
        view.addSubview(webView)

        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupProgressView() {
        progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progressTintColor = .systemBlue
        progressView.trackTintColor = .clear
        navigationController?.navigationBar.addSubview(progressView)

        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: navigationController!.navigationBar.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: navigationController!.navigationBar.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: navigationController!.navigationBar.bottomAnchor)
        ])

        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.isHidden = webView.estimatedProgress >= 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }

    @objc private func didTapBack() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @objc private func didDimiss() {
        
        let alert = UIAlertController(
                title: "Are you sure?",
                message: "Do you want to close?",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak self] _ in
                guard let self = self else { return }
                if let nav = self.navigationController, nav.viewControllers.first != self {
                    nav.popViewController(animated: true)
                } else {
                    self.dismiss(animated: true)
                }
            }))

            present(alert, animated: true)
    }

    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

extension WebViewController: WKNavigationDelegate {}








