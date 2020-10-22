//
//  GridView.swift
//  AffTranDemo
//
//  Created by jaydeep on 16/10/20.
//

import UIKit

class GridView: UIView {
    private let pointsPerUnit = 5

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        self.backgroundColor = .black
        self.contentMode = .redraw
    }

    override func draw(_ rect: CGRect) {
        drawGridLines(axis: .horizontal, size: rect.width)
        drawGridLines(axis: .vertical, size: rect.height)
    }

    private func drawGridLines(axis: NSLayoutConstraint.Axis, size: CGFloat) {
        let totalUnits = Int(size) / pointsPerUnit
        for unit in (0...totalUnits / 2) {
            if unit == 0 {
                UIColor.white.setStroke()
            } else if unit % 10 == 0 {
                UIColor.cyan.setStroke()
            } else if unit % 5 == 0 {
                UIColor.gray.setStroke()
            } else {
                UIColor.gray.withAlphaComponent(0.6).setStroke()
            }
            let positive = Int(size / 2) + (unit * pointsPerUnit)
            let negative = Int(size / 2) - (unit * pointsPerUnit)
            let path = UIBezierPath()
            path.lineWidth = 0.5

            switch axis {
            case .horizontal:
                path.move(to: CGPoint(x: positive, y: 0))
                path.addLine(to: CGPoint(x: positive, y: Int(size)))
                path.move(to: CGPoint(x: negative, y: 0))
                path.addLine(to: CGPoint(x: negative, y: Int(size)))
            case .vertical:
                path.move(to: CGPoint(x: 0, y: positive))
                path.addLine(to: CGPoint(x: Int(size), y: positive))
                path.move(to: CGPoint(x: 0, y: negative))
                path.addLine(to: CGPoint(x: Int(size), y: negative))
            @unknown default:
                break
            }

            path.stroke()
            path.close()
        }
    }

    override var intrinsicContentSize: CGSize {
        // Ideally we want to show 200 units along both axes i.e -10 to +10
        let totalPoints = 200 * pointsPerUnit
        return CGSize(width: totalPoints, height: totalPoints)
    }
}
