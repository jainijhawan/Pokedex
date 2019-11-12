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
    
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    
    blurEffectView.frame = fromVC.view.frame
    transitionContext.containerView.addSubview(blurEffectView)
    mySelectedIndex = fromVC.selectedIndex!
    
    let selectedCell = fromVC.pokeCollectionView.cellForItem(at: mySelectedIndex!) as! PokemonCollectionViewCell
    let selectedCellCopy = selectedCell.pokemonImage.snapshotView(afterScreenUpdates: true)
    
    transitionContext.containerView.addSubview(selectedCellCopy!)
        
    x = fromVC.pokeCollectionView.convert(selectedCell.frame, to: fromVC.view)
    
    selectedCellCopy?.frame = CGRect(x: x!.minX, y: x!.minY, width: selectedCell.pokemonImage.frame.width, height: selectedCell.pokemonImage.frame.height)
    
    toVC.view.isHidden = true
    transitionContext.containerView.addSubview(toVC.view)
    
    let y = toVC.imageStackView.convert(toVC.pokemonImage.frame, to: toVC.view)
    
    let scaleFactor = toVC.pokemonImage.frame.width/(selectedCellCopy?.frame.width)!
    
    UIView.animate(withDuration: 0.8, animations: {
      selectedCellCopy?.center = CGPoint(x: y.midX, y: y.midY)
      selectedCellCopy?.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
    }) { (_) in
      selectedCellCopy?.removeFromSuperview()
      toVC.view.isHidden = false
      transitionContext.completeTransition(true)

      }
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
