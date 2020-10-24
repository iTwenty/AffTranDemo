//
//  GridView.swift
//  AffTranDemo
//
//  Created by jaydeep on 16/10/20.
//

import UIKit

class GridView: UIView {
    private let pointsPerMm: CGFloat = 5

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
        drawGridLines(axis: .horizontal, rect: rect)
        drawGridLines(axis: .vertical, rect: rect)
        drawIHat(rect)
        drawJHat(rect)
    }

    private func drawGridLines(axis: NSLayoutConstraint.Axis, rect: CGRect) {
        let size = axis == .horizontal ? rect.width : rect.height
        let totalUnits = Int(size / pointsPerMm)
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
            let positive = size / 2 + (CGFloat(unit) * pointsPerMm)
            let negative = size / 2 - (CGFloat(unit) * pointsPerMm)
            let path = UIBezierPath()
            path.lineWidth = 0.5

            switch axis {
            case .horizontal:
                path.move(to: CGPoint(x: positive, y: 0))
                path.addLine(to: CGPoint(x: positive, y: size))
                path.move(to: CGPoint(x: negative, y: 0))
                path.addLine(to: CGPoint(x: negative, y: size))
            case .vertical:
                path.move(to: CGPoint(x: 0, y: positive))
                path.addLine(to: CGPoint(x: size, y: positive))
                path.move(to: CGPoint(x: 0, y: negative))
                path.addLine(to: CGPoint(x: size, y: negative))
            @unknown default:
                break
            }

            path.stroke()
            path.close()
        }
    }

    private func drawIHat(_ rect: CGRect) {
        let iHatStart = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let iHatEnd = CGPoint(x: rect.width / 2 + 10 * pointsPerMm, y: rect.height / 2)
        let path = UIBezierPath()
        path.lineWidth = 2
        UIColor.yellow.setStroke()
        path.move(to: iHatStart)
        path.addLine(to: iHatEnd)
        path.addLine(to: CGPoint(x: iHatEnd.x - pointsPerMm, y: iHatEnd.y - pointsPerMm))
        path.move(to: iHatEnd)
        path.addLine(to: CGPoint(x: iHatEnd.x - pointsPerMm, y: iHatEnd.y + pointsPerMm))
        path.stroke()
        path.close()
    }

    private func drawJHat(_ rect: CGRect) {
        let jHatStart = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let jHatEnd = CGPoint(x: rect.width / 2, y: rect.height / 2 + 10 * pointsPerMm)
        let path = UIBezierPath()
        path.lineWidth = 2
        UIColor.green.setStroke()
        path.move(to: jHatStart)
        path.addLine(to: jHatEnd)
        path.addLine(to: CGPoint(x: jHatEnd.x + pointsPerMm, y: jHatEnd.y - pointsPerMm))
        path.move(to: jHatEnd)
        path.addLine(to: CGPoint(x: jHatEnd.x - pointsPerMm, y: jHatEnd.y - pointsPerMm))
        path.stroke()
        path.close()
    }

    override var intrinsicContentSize: CGSize {
        // Ideally we want to show 200 units along both axes i.e -10 to +10
        let totalPoints = 200 * pointsPerMm
        return CGSize(width: totalPoints, height: totalPoints)
    }
}
