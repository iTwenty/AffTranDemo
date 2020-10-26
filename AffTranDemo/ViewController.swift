//
//  ViewController.swift
//  AffTranDemo
//
//  Created by jaydeep on 16/10/20.
//

import UIKit

class ViewController: UIViewController {

    var animator: UIViewPropertyAnimator?

    lazy var bgGridView: GridView = {
        let view = GridView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var fgGridView: GridView = {
        let view = GridView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.transformVectorsAction = { (iHatPosition: CGPoint, jHatPosition: CGPoint) in
            let transform = CGAffineTransform(a: iHatPosition.x, b: iHatPosition.y,
                                              c: jHatPosition.x, d: jHatPosition.y,
                                              tx: 0, ty: 0)
            let currentAnimFraction = self.animator?.fractionComplete ?? 0
            self.animator?.fractionComplete = 0
            self.animator?.stopAnimation(false)
            self.animator?.finishAnimation(at: .current)
            self.bgGridView.transform = .identity
            self.animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear) {
                self.bgGridView.transform = transform
            }
            self.animator?.fractionComplete = currentAnimFraction
        }
        return view
    }()

    lazy var gridScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var transformSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(transformSliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()

    lazy var settingsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.addTarget(self, action: #selector(didClickSettingsButton(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(gridScrollView)
        view.addSubview(settingsButton)
        view.addSubview(transformSlider)
        gridScrollView.addSubview(bgGridView)
        gridScrollView.addSubview(fgGridView)
        NSLayoutConstraint.activate([
            gridScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gridScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gridScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            gridScrollView.bottomAnchor.constraint(equalTo: transformSlider.safeAreaLayoutGuide.topAnchor),
            bgGridView.leadingAnchor.constraint(equalTo: gridScrollView.contentLayoutGuide.leadingAnchor),
            bgGridView.topAnchor.constraint(equalTo: gridScrollView.contentLayoutGuide.topAnchor),
            bgGridView.trailingAnchor.constraint(equalTo: gridScrollView.contentLayoutGuide.trailingAnchor),
            bgGridView.bottomAnchor.constraint(equalTo: gridScrollView.contentLayoutGuide.bottomAnchor),
            fgGridView.leadingAnchor.constraint(equalTo: bgGridView.leadingAnchor),
            fgGridView.topAnchor.constraint(equalTo: bgGridView.topAnchor),
            fgGridView.trailingAnchor.constraint(equalTo: bgGridView.trailingAnchor),
            fgGridView.bottomAnchor.constraint(equalTo: bgGridView.bottomAnchor),
            transformSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            transformSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            transformSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingsButton.bottomAnchor.constraint(equalTo: transformSlider.safeAreaLayoutGuide.topAnchor)
        ])
        bgGridView.backgroundColor = .black
        bgGridView.showTransformVectors = false
        fgGridView.backgroundColor = .clear
        fgGridView.showGridLines = false
        fgGridView.showUnitVectors = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let centerOffsetX = (gridScrollView.contentSize.width - gridScrollView.frame.size.width) / 2
        let centerOffsetY = (gridScrollView.contentSize.height - gridScrollView.frame.size.height) / 2
        let centerPoint = CGPoint(x: centerOffsetX, y: centerOffsetY)
        gridScrollView.setContentOffset(centerPoint, animated: false)
    }

    @objc func transformSliderValueDidChange(_ slider: UISlider) {
        guard let animator = self.animator else { return }
        if animator.state != .active {
            animator.startAnimation()
            animator.pauseAnimation()
        }
        animator.fractionComplete = CGFloat(slider.value)
    }

    @objc func didClickSettingsButton(_ button: UIButton) {
        print("Settings tapped")
    }
}

