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
        drawGrid(width: rect.width, height: rect.height)
    }

    private func drawGrid(width: CGFloat, height: CGFloat) {
        let xCenter = width / 2
        let yCenter = height / 2
        let xUnits = Int(width) / pointsPerUnit
        let yUnits = Int(height) / pointsPerUnit

        for xUnit in (0...xUnits / 2) {
            if xUnit == 0 {
                UIColor.white.setStroke()
            } else if xUnit % 10 == 0 {
                UIColor.cyan.setStroke()
            } else if xUnit % 5 == 0 {
                UIColor.gray.setStroke()
            } else {
                UIColor.gray.withAlphaComponent(0.6).setStroke()
            }
            let positiveX = Int(xCenter) + (xUnit * pointsPerUnit)
            let negativeX = Int(xCenter) - (xUnit * pointsPerUnit)
            let path = UIBezierPath()
            path.lineWidth = 0.5
            path.move(to: CGPoint(x: positiveX, y: 0))
            path.addLine(to: CGPoint(x: positiveX, y: Int(height)))
            path.move(to: CGPoint(x: negativeX, y: 0))
            path.addLine(to: CGPoint(x: negativeX, y: Int(height)))
            path.stroke()
            path.close()
        }

        for yUnit in (0...yUnits / 2) {
            if yUnit == 0 {
                UIColor.white.setStroke()
            } else if yUnit % 10 == 0 {
                UIColor.cyan.setStroke()
            } else if yUnit % 5 == 0 {
                UIColor.gray.setStroke()
            } else {
                UIColor.gray.withAlphaComponent(0.6).setStroke()
            }
            let positiveY = Int(yCenter) + (yUnit * pointsPerUnit)
            let negativeY = Int(yCenter) - (yUnit * pointsPerUnit)
            let path = UIBezierPath()
            path.lineWidth = 0.5
            path.move(to: CGPoint(x: 0, y: positiveY))
            path.addLine(to: CGPoint(x: Int(width), y: positiveY))
            path.move(to: CGPoint(x: 0, y: negativeY))
            path.addLine(to: CGPoint(x: Int(width), y: negativeY))
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
