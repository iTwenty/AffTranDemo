//
//  CrosshairView.swift
//  AffTranDemo
//
//  Created by jaydeep on 24/10/20.
//

import UIKit

class CrosshairView: UIView {
    private var circleWidth: CGFloat = 1

    public var color: UIColor = .blue {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        self.backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: center.y))
        path.addLine(to: CGPoint(x: rect.width, y: center.y))
        path.move(to: CGPoint(x: center.x, y: 0))
        path.addLine(to: CGPoint(x: center.x, y: rect.height))
        path.lineWidth = circleWidth
        color.setStroke()
        path.stroke()
        path.close()
    }
}
