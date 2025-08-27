//
//  ServiceDimissConfirmation.swift
//  MiniAppOtherServices
//
//  Created by Universe on 22/8/25.
//

import UIKit

class ServiceConfirmationToggleView: UIView {

    var onConfirm: (() -> Void)?
    var onCancel: (() -> Void)?

    fileprivate let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()

    fileprivate let logoContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightBorder.cgColor
        view.clipsToBounds = true
        return view
    }()

    fileprivate let serviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    fileprivate let serviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    fileprivate let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .subtitleColor
        return label
    }()

    fileprivate let cancelButton = ServiceConfirmationToggleView.makeButton(title: "Cancel", bgColor: .white, textColor: .titleColor, borderColor: .black)
    fileprivate let confirmButton = ServiceConfirmationToggleView.makeButton(title: "OK", bgColor: .white, textColor: .red, borderColor: .red)

    fileprivate var logoWidthConstraint: NSLayoutConstraint?
    fileprivate var logoHeightConstraint: NSLayoutConstraint?

    init(service: ServiceModel) {
        super.init(frame: .zero)
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        alpha = 0

        serviceImageView.image = UIImage(named: service.logo)
        serviceNameLabel.text = service.name
        messageLabel.text = "Do you want to close \(service.name)?"

        setupLayout()
        setupActions()

        logoWidthConstraint?.constant = service.logoSize.width
        logoHeightConstraint?.constant = service.logoSize.height
        logoContainer.backgroundColor = service.backgroundColor
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    fileprivate func setupLayout() {
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.widthAnchor.constraint(equalToConstant: 320),
            container.heightAnchor.constraint(equalToConstant: 220)
        ])

        [logoContainer, serviceImageView, serviceNameLabel, messageLabel, cancelButton, confirmButton].forEach {
            container.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            logoContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            logoContainer.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            logoContainer.widthAnchor.constraint(equalToConstant: 74),
            logoContainer.heightAnchor.constraint(equalToConstant: 74),

            serviceImageView.centerXAnchor.constraint(equalTo: logoContainer.centerXAnchor),
            serviceImageView.centerYAnchor.constraint(equalTo: logoContainer.centerYAnchor)
        ])
        logoWidthConstraint = serviceImageView.widthAnchor.constraint(equalToConstant: 1)
        logoHeightConstraint = serviceImageView.heightAnchor.constraint(equalToConstant: 1)
        logoWidthConstraint?.isActive = true
        logoHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            serviceNameLabel.topAnchor.constraint(equalTo: logoContainer.bottomAnchor, constant: 6),
            serviceNameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            serviceNameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),

            messageLabel.topAnchor.constraint(equalTo: serviceNameLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: cancelButton.topAnchor, constant: -12),

            cancelButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -18),
            cancelButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            cancelButton.widthAnchor.constraint(equalToConstant: 128),
            cancelButton.heightAnchor.constraint(equalToConstant: 45),

            confirmButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -18),
            confirmButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            confirmButton.widthAnchor.constraint(equalToConstant: 128),
            confirmButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    fileprivate func setupActions() {
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOutside))
        addGestureRecognizer(tap)
    }

    @objc private func didTapCancel() { hide(); onCancel?() }
    @objc private func didTapConfirm() { hide(); onConfirm?() }
    @objc private func didTapOutside(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        if !container.frame.contains(location) {
            hide()
            onCancel?()
        }
    }

    func show(in parent: UIView) {
        frame = parent.bounds
        parent.addSubview(self)
        UIView.animate(withDuration: 0.25) { self.alpha = 1 }
    }

    func hide() {
        UIView.animate(withDuration: 0.25, animations: { self.alpha = 0 }) { _ in
            self.removeFromSuperview()
        }
    }

    fileprivate static func makeButton(title: String, bgColor: UIColor, textColor: UIColor, borderColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = bgColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1
        button.layer.borderColor = borderColor.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }
}
