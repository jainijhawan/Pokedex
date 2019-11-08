//
//  FlipPresentAnimationController.swift
//  PokeDex
//
//  Created by Jai Nijhawan on 05/11/19.
//  Copyright © 2019 Jai Nijhawan. All rights reserved.
//

import UIKit

enum TransitionType {
  case goingForwards
  case goingBackwards
}

class PresentingAnimator: NSObject,
UIViewControllerAnimatedTransitioning {
  
  private let originFrame = CGRect.zero
  var transition: TransitionType = .goingForwards
  var mySelectedIndex: IndexPath?

  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 2.0
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    // 1
    let fromVC = transitionContext.viewController(forKey: .from)
    let toVC = transitionContext.viewController(forKey: .to)
    
    if transition == .goingForwards {
      let fromVC = fromVC as! HomeVC
      let toVC = toVC as! DetailsVC
      
      mySelectedIndex = fromVC.selectedIndex!
      
      let selectedCell = fromVC.pokeCollectionView.cellForItem(at: mySelectedIndex!)
      
      let x = fromVC.pokeCollectionView.convert(selectedCell!.frame, to: fromVC.view)
      
      transitionContext.containerView.addSubview(toVC.view)
    
      toVC.view.center = CGPoint(x: x.midX, y: x.midY)
  
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
      
//      UIView.animate(withDuration: 0.5, animations: {
//        selectedCell!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//        print(fromVC.selectedIndex!)
//        toVC.view.frame = fromVC.pokeCollectionView.convert(selectedCell!.frame, to: fromVC.view)
//
//      }) { (_) in
//
//        //toVC.view.transform = CGAffineTransform(scaleX: 1, y: 0.9)
//        print(fromVC.pokeCollectionView.convert(selectedCell!.frame, from: fromVC.view))
//        print(toVC.view.frame)
//        transitionContext.containerView.addSubview(toVC.view)
//        transitionContext.completeTransition(true)
//      }
      
    } else {

      
      UIView.animate(withDuration: 2) {
        fromVC!.view.transform = CGAffineTransform(scaleX: 0, y: 0)
               //fromVC.view.center = (toVC.pokeCollectionView.cellForItem(at: self.mySelectedIndex!)?.contentView.center)!
      }
      transitionContext.completeTransition(true)
    }
        
  }
  
  
}
extension PresentingAnimator: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition = .goingForwards
    return self
  }
  
 func animationController(forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
      transition = .goingBackwards

      
      
    guard let _ = dismissed as? DetailsVC   else {
      return nil
    }
    return self
  }
}
