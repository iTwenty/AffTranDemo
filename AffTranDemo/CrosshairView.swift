//
//  CrosshairView.swift
//  AffTranDemo
//
//  Created by jaydeep on 24/10/20.
//

import UIKit

class CrosshairView: UIView {
    private var circleWidth: CGFloat = 2

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
        let radius = ((rect.width > rect.height) ? rect.midY : rect.midX) - circleWidth
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0,
                                endAngle: CGFloat(2 * Double.pi), clockwise: true)
        path.lineWidth = circleWidth
        color.setStroke()
        path.stroke()
        path.close()
    }
}
