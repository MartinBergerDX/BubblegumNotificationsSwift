//
//  ShapeDrawer.swift
//  swift-shape-draw
//
//  Created by Martin Berger on 10/13/16.
//  Copyright © 2016 codecentric. All rights reserved.
//

import UIKit

class ShapeDrawer: UIView, DisplayLinkerDelegate {
    internal var linker: DisplayLinker? = nil
    internal var shapePath: CGPath? = nil
    
    internal let indianRed   = UIColor.init(red: 205 / 255, green: 92  / 255, blue: 92  / 255, alpha: 1.0)
    internal let salmon      = UIColor.init(red: 250 / 255, green: 128 / 255, blue: 114 / 255, alpha: 1.0)
    internal let darkSalmon  = UIColor.init(red: 233 / 255, green: 150 / 255, blue: 122 / 255, alpha: 1.0)
    internal let darkBlue    = UIColor.init(red: 52  / 255, green: 73  / 255, blue: 94  / 255, alpha: 1.0)
    internal let orange      = UIColor.init(red: 211 / 255, green: 84  / 255, blue: 0        , alpha: 1.0)
    internal let lightBlue   = UIColor.init(red: 46  / 255, green: 134 / 255, blue: 193 / 255, alpha: 1.0)
    
    internal var first: DrawableRectangle?
    internal var second: DrawableRectangle?
    internal var third: DrawableRectangle?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShapeDrawer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupShapeDrawer()
    }
    
    func setupShapeDrawer() {
        self.linker = DisplayLinker.init(withDelegate: self)
        self.first  = DrawableRectangle.init(view: self, color: self.indianRed, row: 0)
        self.second = DrawableRectangle.init(view: self, color: self.darkBlue, row: 1, inset: 100.0)
        self.third  = DrawableRectangle.init(view: self, color: self.orange, row: 2, inset: 200.0)
    }
    
    override func draw(_ rect: CGRect) {
        self.first?.draw()
        self.second?.draw()
        self.third?.draw()
    }
    
    func displayLinkUpdate(delta: TimeInterval) {
        self.setNeedsDisplay()
        self.first?.update(delta: delta)
        self.second?.update(delta: delta)
        self.third?.update(delta: delta)
    }
}

internal class DrawableRectangle {
    var color: UIColor
    var progress: CGFloat = 0.0
    var shouldDraw: Bool = false
    var inset: CGFloat = 0.0
    var row: Int = 0
    weak var view: UIView? = nil
    
    init(view: UIView, color: UIColor, row: Int = 0, inset: CGFloat = 0.0) {
        self.view = view
        self.color = color
        self.row = row
        self.inset = inset
        self.progress = -inset
    }
    
    func draw() {
        guard self.shouldDraw == true else {
            return
        }
        let height = (self.view?.frame.height)! / 3.0
        let y = height * CGFloat(row)
        let rect = CGRect.init(x: 0.0, y: y, width: self.progress, height: height)
        fill(rectangle: rect, color: self.color)
    }
    
    private func fill(rectangle rect: CGRect, color: UIColor) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
    }
    
    func update(delta: TimeInterval) {
        let increment = 30.0 * CGFloat(delta)
        
        guard (self.progress < (self.view?.frame.width)!) == true else {
            self.progress = (self.view?.frame.width)!
            return
        }
        
        self.progress += increment
        if self.progress >= 0.0 {
            self.shouldDraw = true
        }
    }
}
