//
//  ViewController.swift
//  InertionSquareProject
//
//  Created by Gamid Gapizov on 16.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var squareView = UIImageView()
    var animator = UIDynamicAnimator()
    var snapBehavior: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createGestureRecognizer()
        createSmallSquareView()
        createAnimatorAndBehavior()
    }
    
    func createGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMethod))
        view.addGestureRecognizer(tap)
    }
    
    func createSmallSquareView() {
        squareView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        squareView.center = view.center
        squareView.image = UIImage(named: "sparrow")
        squareView.layer.cornerRadius = 10
        squareView.layer.masksToBounds = true
        view.addSubview(squareView)
    }
    
    func createAnimatorAndBehavior() {
        animator = UIDynamicAnimator(referenceView: view)
        
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        snapBehavior = UISnapBehavior(item: squareView, snapTo: squareView.center)
        snapBehavior?.damping = 0.3
    }
    
    @objc func tapMethod(param: UITapGestureRecognizer) {
        let tapPoint = param.location(in: view)
        
        if snapBehavior != nil {
            animator.removeBehavior(snapBehavior!)
        }
        
        snapBehavior = .init(item: squareView, snapTo: tapPoint)
        snapBehavior?.damping = 1.5
        animator.addBehavior(snapBehavior!)
    }
}
