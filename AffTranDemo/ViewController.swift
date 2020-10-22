//
//  ViewController.swift
//  AffTranDemo
//
//  Created by jaydeep on 16/10/20.
//

import UIKit

class ViewController: UIViewController {

    lazy var gridView: GridView = {
        let view = GridView()
        view.translatesAutoresizingMaskIntoConstraints = false
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

    lazy var animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear) {
        self.gridView.transform = CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 0, ty: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(gridScrollView)
        view.addSubview(settingsButton)
        view.addSubview(transformSlider)
        gridScrollView.addSubview(gridView)
        NSLayoutConstraint.activate([
            gridScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gridScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gridScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            gridScrollView.bottomAnchor.constraint(equalTo: transformSlider.safeAreaLayoutGuide.topAnchor),
            gridView.leadingAnchor.constraint(equalTo: gridScrollView.contentLayoutGuide.leadingAnchor),
            gridView.topAnchor.constraint(equalTo: gridScrollView.contentLayoutGuide.topAnchor),
            gridView.trailingAnchor.constraint(equalTo: gridScrollView.contentLayoutGuide.trailingAnchor),
            gridView.bottomAnchor.constraint(equalTo: gridScrollView.contentLayoutGuide.bottomAnchor),
            transformSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            transformSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            transformSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingsButton.bottomAnchor.constraint(equalTo: transformSlider.safeAreaLayoutGuide.topAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let centerOffsetX = (gridScrollView.contentSize.width - gridScrollView.frame.size.width) / 2
        let centerOffsetY = (gridScrollView.contentSize.height - gridScrollView.frame.size.height) / 2
        let centerPoint = CGPoint(x: centerOffsetX, y: centerOffsetY)
        gridScrollView.setContentOffset(centerPoint, animated: false)
    }

    @objc func transformSliderValueDidChange(_ slider: UISlider) {
        if animator.state != .active {
            animator.startAnimation()
            animator.pauseAnimation()
        }
        animator.fractionComplete = CGFloat(slider.value)
    }

    @objc func didClickSettingsButton(_ button: UIButton) {
        print(button.image(for: .normal)?.size ?? "")
    }
}

