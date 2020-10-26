//
//  GridView.swift
//  AffTranDemo
//
//  Created by jaydeep on 16/10/20.
//

import UIKit

class GridView: UIView {
    fileprivate static let pointsPerMm: CGFloat = 5

    public var showUnitVectors: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }

    public var showGridLines: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }

    public var showTransformVectors: Bool = true {
        didSet {
            self.transformIHat.isHidden = !showTransformVectors
            self.transformJHat.isHidden = !showTransformVectors
            self.transformIHat.isUserInteractionEnabled = showTransformVectors
            self.transformJHat.isUserInteractionEnabled = showTransformVectors        
        }
    }

    public var transformVectorsAction: ((_ iHatPosition: CGPoint, _ jHatPosition: CGPoint) -> Void)?

    private lazy var iHatPan: UIPanGestureRecognizer = {
        let pangr = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        return pangr
    }()

    private lazy var jHatPan: UIPanGestureRecognizer = {
        let pangr = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        return pangr
    }()

    private lazy var transformIHat: CrosshairView = {
        let view = CrosshairView()
        view.color = .yellow
        return view
    }()

    private lazy var transformJHat: CrosshairView = {
        let view = CrosshairView()
        view.color = .green
        return view
    }()

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
        self.addSubview(transformIHat)
        self.addSubview(transformJHat)
        transformIHat.addGestureRecognizer(iHatPan)
        transformJHat.addGestureRecognizer(jHatPan)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let s = 3
        transformIHat.frame = CGRect(x: self.bounds.midX + (10 - s).mm,
                               y: self.bounds.midY - s.mm,
                               width: 2 * s.mm, height: 2 * s.mm)
        transformJHat.frame = CGRect(x: self.bounds.midX - s.mm,
                               y: self.bounds.midY + (10 - s).mm,
                               width: 2 * s.mm, height: 2 * s.mm)
    }

    // MARK: UIView overridden methods

    override func draw(_ rect: CGRect) {
        if showGridLines {
            drawGridLines(axis: .horizontal, rect: rect)
            drawGridLines(axis: .vertical, rect: rect)
        }
        if showUnitVectors {
            drawIHat(rect)
            drawJHat(rect)
        }
    }

    override var intrinsicContentSize: CGSize {
        // Ideally we want to show 200 mm along both axes i.e -10cm to +10cm
        let totalSize = 200.mm
        return CGSize(width: totalSize, height: totalSize)
    }

    // MARK: Private drawing methods

    private func drawGridLines(axis: NSLayoutConstraint.Axis, rect: CGRect) {
        let size = axis == .horizontal ? rect.width : rect.height
        let totalUnits = Int(size / GridView.pointsPerMm)
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
            let positive = size / 2 + unit.mm
            let negative = size / 2 - unit.mm
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
        let iHatStart = CGPoint(x: rect.midX, y: rect.midY)
        let iHatEnd = CGPoint(x: rect.midX + 10.mm, y: rect.midY)
        let path = UIBezierPath()
        path.lineWidth = 2
        UIColor.yellow.setStroke()
        path.move(to: iHatStart)
        path.addLine(to: iHatEnd)
        path.addLine(to: CGPoint(x: iHatEnd.x - 1.mm, y: iHatEnd.y - 1.mm))
        path.move(to: iHatEnd)
        path.addLine(to: CGPoint(x: iHatEnd.x - 1.mm, y: iHatEnd.y + 1.mm))
        path.stroke()
        path.close()
    }

    private func drawJHat(_ rect: CGRect) {
        let jHatStart = CGPoint(x: rect.midX, y: rect.midY)
        let jHatEnd = CGPoint(x: rect.midX, y: rect.midY + 10.mm)
        let path = UIBezierPath()
        path.lineWidth = 2
        UIColor.green.setStroke()
        path.move(to: jHatStart)
        path.addLine(to: jHatEnd)
        path.addLine(to: CGPoint(x: jHatEnd.x + 1.mm, y: jHatEnd.y - 1.mm))
        path.move(to: jHatEnd)
        path.addLine(to: CGPoint(x: jHatEnd.x - 1.mm, y: jHatEnd.y - 1.mm))
        path.stroke()
        path.close()
    }

    @objc private func didPan(_ pangr: UIPanGestureRecognizer) {
        guard pangr.view == transformIHat || pangr.view == transformJHat else { return }
        if pangr.state == .changed {
            pangr.view?.center = pangr.location(in: self)
        }
        if pangr.state == .ended {
            let transformIHatPosition = CGPoint(x: (transformIHat.center.x - self.bounds.midX) / (GridView.pointsPerMm * 10),
                                                y: (transformIHat.center.y - self.bounds.midY) / (GridView.pointsPerMm * 10))
            let transformJHatPosition = CGPoint(x: (transformJHat.center.x - self.bounds.midX) / (GridView.pointsPerMm * 10),
                                                y: (transformJHat.center.y - self.bounds.midY) / (GridView.pointsPerMm * 10))
            transformVectorsAction?(transformIHatPosition, transformJHatPosition)
        }
    }
}

fileprivate extension Int {
    var mm: CGFloat {
        CGFloat(self) * GridView.pointsPerMm
    }
}
