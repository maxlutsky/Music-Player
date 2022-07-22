//
//  SongProgress.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 22.07.2022.
//

import UIKit

class SongProgress: UIView {

    override var tintColor: UIColor! {
        didSet {
            currentProgress.textColor = tintColor
            songDuration.textColor = tintColor
            progressView.progressTintColor = tintColor
        }
    }

    public var current: String? {
        didSet {
            currentProgress.text = current
        }
    }

    public var totalDuration: String? {
        didSet {
            songDuration.text = totalDuration
        }
    }

    private let currentProgress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let songDuration: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0.0
        return progressView
    }()

    init() {
        super.init(frame: .zero)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }

    public func setProgress(_ progress: Float, animated: Bool) {
        progressView.setProgress(progress, animated: animated)
    }

    private func setupConstraints() {
        addSubview(currentProgress)
        addSubview(songDuration)
        addSubview(progressView)

        NSLayoutConstraint.activate([
            currentProgress.leftAnchor.constraint(equalTo: leftAnchor),
            currentProgress.topAnchor.constraint(equalTo: topAnchor),
            currentProgress.rightAnchor.constraint(equalTo: centerXAnchor),
            currentProgress.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -Constants.defaultSpacing),

            songDuration.leftAnchor.constraint(equalTo: centerXAnchor),
            songDuration.topAnchor.constraint(equalTo: topAnchor),
            songDuration.rightAnchor.constraint(equalTo: rightAnchor),
            songDuration.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -Constants.defaultSpacing),

            progressView.leftAnchor.constraint(equalTo: leftAnchor),
            progressView.rightAnchor.constraint(equalTo: rightAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
