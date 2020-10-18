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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(gridView)
        NSLayoutConstraint.activate([
            gridView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gridView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gridView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            gridView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.backgroundColor = .red
    }
}

