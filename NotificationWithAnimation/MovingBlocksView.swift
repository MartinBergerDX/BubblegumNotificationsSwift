//
//  MovingBlocksView.swift
//  LayerAnimation
//
//  Created by Martin Berger on 10/12/16.
//  Copyright © 2016 heavy-debugging.inc. All rights reserved.
//

import UIKit

class MovingBlocksView: UIView, DisplayLinkerDelegate {
    @IBInspectable var speed: Double = 0.0
    @IBInspectable var rows: Int = 0
    @IBInspectable var blockWidth: Float = 0
    
    var blockHeight: Float {
        get {
            let viewHeight = self.frame.height
            let rows = self.rows
            let height = Float(viewHeight) / Float(rows)
            return height
        }
    }
    
    internal var linker: DisplayLinker? = nil
    internal var layers: [[CALayer]]? = nil
    internal var frontLayers: [CALayer]? = Array<CALayer>.init()
    internal var rowSpeeds: [Double]? = Array<Double>.init()
    
    internal let indianRed   = UIColor.init(red: 205 / 255, green: 92  / 255, blue: 92  / 255, alpha: 1.0)
    internal let salmon      = UIColor.init(red: 250 / 255, green: 128 / 255, blue: 114 / 255, alpha: 1.0)
    internal let darkSalmon  = UIColor.init(red: 233 / 255, green: 150 / 255, blue: 122 / 255, alpha: 1.0)
    internal let darkBlue    = UIColor.init(red: 52  / 255, green: 73  / 255, blue: 94  / 255, alpha: 1.0)
    internal let orange      = UIColor.init(red: 211 / 255, green: 84  / 255, blue: 0        , alpha: 1.0)
    internal let lightBlue   = UIColor.init(red: 46  / 255, green: 134 / 255, blue: 193 / 255, alpha: 1.0)
    internal var colors: [UIColor]? = nil
    internal var colorIndex  = 0
    internal var lastViewHeight: CGFloat? = 0
    
    var layersInitialized = false
    
    init(frame: CGRect, speed: Double, blockWidth: Int, rows: Int) {
        super.init(frame: frame)
        
        setup(speed: speed, blockWidth: blockWidth, rows: rows)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !self.layersInitialized {
            self.layersInitialized = true
            setup(blocks: self.rows)
            self.lastViewHeight = self.frame.height
        }
        else if self.lastViewHeight != self.frame.height {
            self.lastViewHeight = self.frame.height
            updateLayerHeights()
        }
    }
    
    private func commonSetup() {
        self.colors = [indianRed, darkBlue, orange, lightBlue, salmon, darkSalmon]
        self.linker = DisplayLinker.init(withDelegate: self)
    }
    
    private func setup(speed: Double, blockWidth: Int, rows: Int) {
        self.speed = speed
        self.blockWidth = Float(blockWidth)
        self.rows = rows
    }
    
    private func setup(blocks rows: Int) {
        
        var layers = [[CALayer]]()
        let width = self.blockWidth
        let height = self.blockHeight
        var x: Float = 0.0
        var y: Float = 0.0
        let viewWidth = Float(self.frame.width)
        var groupWidth = Float(0.0)
        
        // create layer rows
        for n: Int in 0...rows {
            var layerRow = [CALayer]()
            let color: UIColor! = self.colors?[self.colorIndex]
            
            // populate row of layers
            while groupWidth < viewWidth {
                let layer = insertLayer(x: x, y: y, width: width, height: height, color: color)
                layerRow.append(layer)
                x += width
                groupWidth += width
            }
            
            // setup for next layer creation loop
            x = 0.0
            y = height * Float(n)
            groupWidth = 0.0
            
            // increment colors
            self.colorIndex += 1
            if self.colorIndex >= (self.colors?.count)! {
                self.colorIndex = 0
            }
            
            // custom speed for row
            let rowSpeed: Double = (self.speed * (Double(arc4random_uniform(6)) + 1.0))
            self.rowSpeeds?.append(rowSpeed)
            
            frontLayers?.append(layerRow[0])
            layers.append(layerRow)
        }
        
        self.layers = layers
    }
    
    func displayLinkUpdate(delta: TimeInterval) {
        updateLayers(delta: delta)
    }
    
    
    private func addLayers() {
        guard self.layers != nil else {
            return
        }
        for layerRow: [CALayer] in self.layers! {
            for layer: CALayer in layerRow {
                self.layer.addSublayer(layer)
            }
        }
    }
    
    private func removeLayers() {
        guard self.layers != nil else {
            return
        }
        self.layer.sublayers?.removeAll()
    }
}

fileprivate extension MovingBlocksView {
    func updateLayers(delta: TimeInterval) {
        insertNewLayersIfNeeded()
        updateLayerPositions(delta: delta)
    }
    
    func insertNewLayersIfNeeded() {
        for rowIndex: Int in 0...((self.layers?.count)! - 1) {
            var layerRow: [CALayer] = self.layers![rowIndex]
            let layer = layerRow[0]
            
            let add = checkAddNew(layer: layer)
            if add == true {
                let newLayer = insertLayer(forLayer: layer)
                layerRow.insert(newLayer, at: 0)
                self.layers?[rowIndex] = layerRow
            }
        }
    }
    
    func updateLayerPositions(delta: TimeInterval) {
        for rowIndex: Int in 0...((self.layers?.count)! - 1) {
            var layerRow: [CALayer] = self.layers![rowIndex]
            for layerIndex: Int in 0...(layerRow.count - 1) {
                guard layerIndex < layerRow.count else {
                    continue
                }
                
                let layer = layerRow[layerIndex]
                layer.frame.origin.x += CGFloat(speed * delta)
                
                if checkRemove(layer: layer) {
                    layer.removeFromSuperlayer()
                    layerRow.remove(at: layerIndex)
                    self.layers?[rowIndex] = layerRow
                }
            }
        }
    }
    
    func insertLayer(x: Float, y: Float, width: Float, height: Float, color: UIColor) -> CALayer {
        let layer = CALayer.init()
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
        layer.backgroundColor = color.cgColor
        self.layer.addSublayer(layer)
        layer.frame = CGRect.init(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
        return layer
    }
    
    func insertLayer(forLayer layer: CALayer) -> CALayer {
        let x = (Float(layer.frame.origin.x) - self.blockWidth)
        let y = Float(layer.frame.origin.y)
        let width = self.blockWidth
        let height = self.blockHeight
        let color = UIColor.init(cgColor: layer.backgroundColor!)
        let layer = insertLayer(x: x, y: y, width: width, height: height, color: color)
        return layer
    }
    
    func checkAddNew(layer: CALayer) -> Bool {
        if layer.frame.origin.x >= 0.0 {
            return true
        }
        return false
    }
    
    func checkRemove(layer: CALayer) -> Bool {
        return (layer.frame.origin.x > self.layer.frame.width ? true : false)
    }
    
    func updateLayerHeights() {
        let height = self.blockHeight
        var y: Float = 0.0
        
        for rowIndex: Int in 0...((self.layers?.count)! - 1) {
            var layerRow: [CALayer] = self.layers![rowIndex]
            for layerIndex: Int in 0...(layerRow.count - 1) {
                guard layerIndex < layerRow.count else {
                    continue
                }
                let layer = layerRow[layerIndex]
                layer.frame.origin.y = CGFloat(y)
                layer.frame.size.height = CGFloat(height)
            }
            
            y += height
        }
    }
}
