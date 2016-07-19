//
//  BreakOutBehavior.swift
//  BreakOutGame
//
//  Created by Ilya Dolgopolov on 14/07/16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class BreakOutBehavior: UIDynamicBehavior {
    
    //гравитация - поведение при падеии объектов
    private let gravity: UIGravityBehavior = {
        let gravity = UIGravityBehavior()
        gravity.magnitude = 1.0
        return gravity
    }()
    
    private let brickBehaviour: UIDynamicItemBehavior = {
        let dbb = UIDynamicItemBehavior()
        
        //выключение ротации (кручения)
        dbb.allowsRotation = false
        
        //прыгучесть: 1.0-сильно, 0.1 - слабо
        dbb.elasticity = 0.5
        return dbb
    }()
    
    //столкновение - поведение,
    //когда объекты добавленные сюда сталкиваются
    let collider: UICollisionBehavior = {
        
        let collider = UICollisionBehavior()
        
        //задает границы, за кот-е добавленные объекты на проваливаютя
        //границы - view, что добавлено как reference в анимацию
        collider.translatesReferenceBoundsIntoBoundary = false
        
        return collider
    }()
    
    //настройки поведения каждого элемента
    //что добавлены в участники
    private let itemBehaviour: UIDynamicItemBehavior = {
        let dib = UIDynamicItemBehavior()
        
        //выключение ротации (кручения)
        dib.allowsRotation = false
        
        //прыгучесть: 1.0-сильно, 0.1 - слабо
        dib.elasticity = 1.2
        dib.friction = 0.0
        dib.resistance = 0
        
        
        return dib
    }()
    
    //конструктор: при создании объекта добавляются поведения
    //что настроены ранее
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(itemBehaviour)
        addChildBehavior(brickBehaviour)
    }
    
    func addSpecialBrickBehaviour(item: UIDynamicItem) {
        gravity.addItem(item)
        //collider.addItem(item)
        brickBehaviour.addItem(item)
    }
    
    func removeSpecialBrickBehaviour(item: UIDynamicItem) {
        gravity.removeItem(item)
        brickBehaviour.removeItem(item)
    }
    
    
    func addBallBehaviour(item: UIDynamicItem) {
        gravity.addItem(item)
        collider.addItem(item)
        itemBehaviour.addItem(item)
    }
    
    //удаляем элементы из аниации
    func removeBallBehaviour(item: UIDynamicItem) {
        gravity.removeItem(item)
        collider.removeItem(item)
        itemBehaviour.removeItem(item)
    }
    
    func addViewBarrier(path: UIBezierPath, named name: NSCopying) {
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    
    func removeViewBarrier(name: NSCopying) {
        collider.removeBoundaryWithIdentifier(name)
    }
    
}
