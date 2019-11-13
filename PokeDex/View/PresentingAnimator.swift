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
  var previousCellFrame: CGRect?
  var previousImageFrame: CGRect?
  var previousNameFrame: CGRect?
  var previousTypeFrame: CGRect?
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 1.0
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    // 1
    let fromVC = transitionContext.viewController(forKey: .from) as! HomeVC
    let toVC = transitionContext.viewController(forKey: .to) as! DetailsVC
    
    mySelectedIndex = fromVC.selectedIndex!
    
    let selectedCell = fromVC.pokeCollectionView.cellForItem(at: mySelectedIndex!) as! PokemonCollectionViewCell
    
    let selectedCellImageCopy = selectedCell.pokemonImage.snapshotView(afterScreenUpdates: true)
    let selectedCellNameCopy = selectedCell.nameLBL.snapshotView(afterScreenUpdates: true)
    let selectedCellTypeCopy = selectedCell.type.snapshotView(afterScreenUpdates: true)
    
    let absoluteCellFrame = fromVC.pokeCollectionView.convert(selectedCell.frame,
                                                              to: fromVC.view)
    previousCellFrame = absoluteCellFrame
    
    let absoluteCellNameFrame = fromVC.pokeCollectionView.cellForItem(at: mySelectedIndex!)?.convert(selectedCell.nameLBL.frame, to: fromVC.view)
    previousNameFrame = absoluteCellNameFrame
    
    let absoluteCellTypeFrame = fromVC.pokeCollectionView.cellForItem(at: mySelectedIndex!)?.convert(selectedCell.type.frame, to: fromVC.view)
    previousTypeFrame = absoluteCellTypeFrame
    
    let finalImageCenter = toVC.imageStackView.convert(toVC.pokemonImage.center,
                                                       to: toVC.view)
    let finalNameCenter = toVC.middleStackView.convert(toVC.name.center,
                                                       to: toVC.view)
    let finalTypeCenter = toVC.middleStackView.convert(toVC.type.center,
                                                       to: toVC.view)
    
    let whiteView = UIView(frame: absoluteCellFrame)
    whiteView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    whiteView.layer.cornerRadius = 10.0
    
    selectedCellImageCopy?.frame = CGRect(x: absoluteCellFrame.minX,
                                          y: absoluteCellFrame.minY,
                                          width: selectedCell.pokemonImage.frame.width,
                                          height: selectedCell.pokemonImage.frame.height)
    previousImageFrame = selectedCellImageCopy?.frame
    
    selectedCellNameCopy?.frame = absoluteCellNameFrame!
    selectedCellTypeCopy?.frame = absoluteCellTypeFrame!
    
    toVC.view.alpha = 0
    
    transitionContext.containerView.addSubview(whiteView)
    transitionContext.containerView.addSubview(selectedCellImageCopy!)
    transitionContext.containerView.addSubview(selectedCellNameCopy!)
    transitionContext.containerView.addSubview(selectedCellTypeCopy!)
    transitionContext.containerView.addSubview(toVC.view)
    
    
    let scaleFactor = toVC.pokemonImage.frame.width/(selectedCellImageCopy?.frame.width)!
    
    UIView.animate(withDuration: 0.6,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 2.5,
                   options: .curveEaseInOut,
                   animations: {

      selectedCellImageCopy?.center = finalImageCenter
      selectedCellImageCopy?.transform = CGAffineTransform(scaleX: scaleFactor,
                                                           y: scaleFactor)
      
      selectedCellNameCopy?.center = finalNameCenter
      selectedCellTypeCopy?.center = finalTypeCenter
      whiteView.frame = fromVC.view.frame
    }) { (_) in
    
      UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
          toVC.view.alpha = 1
        }) { (_) in
          selectedCellImageCopy?.removeFromSuperview()
          selectedCellNameCopy?.removeFromSuperview()
          selectedCellTypeCopy?.removeFromSuperview()
          
          whiteView.removeFromSuperview()
        }
        transitionContext.completeTransition(true)
      }

    
  }
  
  
}
extension PresentingAnimator: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func animationController(forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
      
      guard let _ = dismissed as? DetailsVC   else {
        return nil
      }
      return DismissingAnimator(previousCellFrame: previousCellFrame!,
                                previousNameFrame: previousNameFrame!,
                                previousTypeFrame: previousTypeFrame!,
                                previousImageFrame: previousImageFrame!)
  }
}
