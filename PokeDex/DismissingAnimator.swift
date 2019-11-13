//
//  DismissingAnimator.swift
//  PokeDex
//
//  Created by Jai Nijhawan on 07/11/19.
//  Copyright © 2019 Jai Nijhawan. All rights reserved.
//

import UIKit

class DismissingAnimator: NSObject,UIViewControllerAnimatedTransitioning {
  
  var previousCellFrame: CGRect!
  var previousNameFrame: CGRect!
  var previousTypeFrame: CGRect!
  var previousImageFrame: CGRect!
  
  convenience init(previousCellFrame: CGRect,
                   previousNameFrame: CGRect,
                   previousTypeFrame: CGRect,
                   previousImageFrame: CGRect) {
    self.init()
    self.previousCellFrame = previousCellFrame
    self.previousNameFrame = previousNameFrame
    self.previousTypeFrame = previousTypeFrame
    self.previousImageFrame = previousImageFrame
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let fromVC = transitionContext.viewController(forKey: .from) as! DetailsVC
    let toVC = transitionContext.viewController(forKey: .to) as! HomeVC
    let containerView = transitionContext.containerView
    
    let selectedCell = toVC.pokeCollectionView.cellForItem(at: toVC.selectedIndex!) as! PokemonCollectionViewCell
    let selectedCellFrame = selectedCell.convert(selectedCell.pokemonImage.frame, to: toVC.view)
    print(selectedCellFrame)
    let imageSnapshot = fromVC.pokemonImage.snapshotView(afterScreenUpdates: true)
    imageSnapshot?.frame = fromVC.imageStackView.convert(fromVC.pokemonImage.frame,
                                                         to: fromVC.view)
    
    let nameSnapshot = fromVC.name.snapshotView(afterScreenUpdates: true)
    nameSnapshot?.frame = fromVC.middleStackView.convert(fromVC.name.frame,
                                                         to: fromVC.view)
    
    let typeSnapshot = fromVC.type.snapshotView(afterScreenUpdates: true)
    typeSnapshot?.frame = fromVC.middleStackView.convert(fromVC.type.frame,
                                                         to: fromVC.view)
    let whiteView = UIView(frame: fromVC.view.frame)
    whiteView.layer.cornerRadius = 10.0
    whiteView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    let scaleFactor = previousImageFrame.width/(imageSnapshot?.frame.width)!
    
    print((imageSnapshot?.frame.width)!)
    print(previousImageFrame)
    
    containerView.addSubview(whiteView)
    containerView.addSubview(imageSnapshot!)
    containerView.addSubview(typeSnapshot!)
    containerView.addSubview(nameSnapshot!)
    fromVC.view.isHidden = true
    
    UIView.animate(withDuration: 0.5, animations: {
      imageSnapshot?.center = CGPoint(x: self.previousImageFrame.midX, y: self.previousImageFrame.midY)
      imageSnapshot?.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
      nameSnapshot?.center = CGPoint(x: self.previousNameFrame.midX, y: self.previousNameFrame.midY)
      typeSnapshot?.center = CGPoint(x: self.previousTypeFrame.midX, y: self.previousTypeFrame.midY)
      
      whiteView.frame = self.previousCellFrame

    }) { (_) in
      transitionContext.completeTransition(true)

      imageSnapshot?.removeFromSuperview()
      nameSnapshot?.removeFromSuperview()
      typeSnapshot?.removeFromSuperview()
      whiteView.removeFromSuperview()

    }
    
  }
  
}

