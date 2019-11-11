//
//  FlipPresentAnimationController.swift
//  PokeDex
//
//  Created by Jai Nijhawan on 05/11/19.
//  Copyright © 2019 Jai Nijhawan. All rights reserved.
//

import UIKit


class PresentingAnimator: NSObject,
UIViewControllerAnimatedTransitioning {
  
  private let originFrame = CGRect.zero
  var mySelectedIndex: IndexPath?
  var x: CGRect?
 
  
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 1.0
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    // 1
    let fromVC = transitionContext.viewController(forKey: .from) as! HomeVC
    let toVC = transitionContext.viewController(forKey: .to) as! DetailsVC
      
      mySelectedIndex = fromVC.selectedIndex!
      
      let selectedCell = fromVC.pokeCollectionView.cellForItem(at: mySelectedIndex!)
      
       x = fromVC.pokeCollectionView.convert(selectedCell!.frame, to: fromVC.view)
      
      transitionContext.containerView.addSubview(toVC.view)
    
    toVC.view.center = CGPoint(x: x!.midX, y: x!.midY)
    
      toVC.view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
      
      UIView.animate(
        withDuration: 0.8,
        animations: {
          toVC.view.center = fromVC.view.center
          toVC.view.transform = CGAffineTransform(scaleX: 1, y: 1)
          
        },
        completion: { _ in
          transitionContext.completeTransition(true)
        }
      )
        
  }
  
  
}
extension PresentingAnimator: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
 func animationController(forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {

    guard let _ = dismissed as? DetailsVC   else {
      return nil
    }
      return DismissingAnimator(originFrame: x!)
  }
}
