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

    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()

    private let serviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()

    private let serviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .subtitleColor
        return label
    }()

    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.titleColor, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()

    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()

    init(service: ServiceModel) {
        super.init(frame: .zero)
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        alpha = 0

        serviceImageView.image = UIImage(named: service.logo)
        serviceNameLabel.text = service.name
        messageLabel.text = "Do you want to close \(service.name)?"

        setupLayout()

        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
    }

    private func setupLayout() {
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.widthAnchor.constraint(equalToConstant: 280),
            container.heightAnchor.constraint(equalToConstant: 220)
        ])

        [serviceImageView, serviceNameLabel, messageLabel, cancelButton, confirmButton].forEach {
            container.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        serviceImageView.backgroundColor = .red

        NSLayoutConstraint.activate([
            serviceImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            serviceImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            serviceImageView.widthAnchor.constraint(equalToConstant: 74),
            serviceImageView.heightAnchor.constraint(equalToConstant: 74),

            serviceNameLabel.topAnchor.constraint(equalTo: serviceImageView.bottomAnchor, constant: 6),
            serviceNameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            serviceNameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),

            messageLabel.topAnchor.constraint(equalTo: serviceNameLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),

            cancelButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -18),
            cancelButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            cancelButton.widthAnchor.constraint(equalToConstant: 108),
            cancelButton.heightAnchor.constraint(equalToConstant: 45),

            confirmButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -18),
            confirmButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            confirmButton.widthAnchor.constraint(equalToConstant: 108),
            confirmButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }

    @objc private func didTapCancel() {
        hide()
        onCancel?()
    }

    @objc private func didTapConfirm() {
        hide()
        onConfirm?()
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

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

