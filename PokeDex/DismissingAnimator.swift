//
//  DismissingAnimator.swift
//  PokeDex
//
//  Created by Jai Nijhawan on 07/11/19.
//  Copyright © 2019 Jai Nijhawan. All rights reserved.
//

import UIKit

class DismissingAnimator: NSObject,UIViewControllerAnimatedTransitioning {
  
  var originFrame: CGRect!
  
  convenience init(originFrame: CGRect) {
     self.init()
     self.originFrame = originFrame
   }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.8
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let fromVC = transitionContext.viewController(forKey: .from) as! DetailsVC
    let toVC = transitionContext.viewController(forKey: .to) as! HomeVC

    transitionContext.containerView.addSubview(fromVC.view)
  
    UIView.animate(
           withDuration: 0.8,
           animations: {
            fromVC.view.center = CGPoint(x: self.originFrame.midX, y: self.originFrame.midY)
            fromVC.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
           },
           completion: { _ in
             transitionContext.completeTransition(true)
           }
         )
  }
  
}

