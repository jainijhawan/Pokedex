//
//  ViewController.swift
//  PokeDex
//
//  Created by Jai Nijhawan on 21/10/19.
//  Copyright © 2019 Jai Nijhawan. All rights reserved.
//

import UIKit
import Kingfisher

class HomeVC: UIViewController {
  
  //MARK: - IBOutlets
  @IBOutlet weak var pokeCollectionView: UICollectionView!
  
  //MARK: - Variabels
  let pokemonURL = URL(string: "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json")
  var pokemonData = [DataStruct]()
  let spacing:CGFloat = 16.0
  
  var tuple = [(name: String,
                image: URL,
                type: String,
                height: String,
                weight: String,
                weakness: String,
                num:String,
    next_evolution: [DataStruct2]?)]()
  
  //MARK: - Lifecycle Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    getData()
    if( traitCollection.forceTouchCapability == .available){
      registerForPreviewing(with: self, sourceView: pokeCollectionView)
    }
    
  }
  
  //MARK: - Custom Methods
  func getData() {
    
    DispatchQueue.global().async {
      if let url = self.pokemonURL {
        if let data = try? Data(contentsOf: url) {
          
          let decoder = JSONDecoder()
          if let jsonData = try? decoder.decode(DataModel.self, from: data) {
            self.pokemonData = jsonData.pokemon
            var x = ""
            var w = ""
            for i in 0..<self.pokemonData.count {
              if self.pokemonData[i].type.first! == self.pokemonData[i].type.last! {
                x = "\(self.pokemonData[i].type.first!)"
              } else {
                x = self.pokemonData[i].type.joined(separator: ", ")
              }
              for i in 0..<self.pokemonData[i].weaknesses.count {
                w = self.pokemonData[i].weaknesses.joined(separator: ", ")
              }
              self.tuple.append((name: self.pokemonData[i].name, image: self.pokemonData[i].img, type: x, height: self.pokemonData[i].height, weight: self.pokemonData[i].weight, weakness: w, num: self.pokemonData[i].num, next_evolution: self.pokemonData[i].next_evolution))
              
            }
            self.tuple = self.tuple.shuffled()
            DispatchQueue.main.async {
              self.pokeCollectionView.isHidden = false
              self.pokeCollectionView.reloadData()
            }
          }
        }
      }
    }
  }
  
  
  func setupUI() {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    layout.minimumLineSpacing = spacing
    layout.minimumInteritemSpacing = spacing
    self.pokeCollectionView?.collectionViewLayout = layout
    pokeCollectionView.isHidden = true
  }
}

//MARK: - Extention CollectionView Delegate
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tuple.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? PokemonCollectionViewCell {
      if tuple.count == 0 {
        cell.nameLBL.text = "Loading"
      } else {
        cell.nameLBL.text = tuple[indexPath.row].name
        cell.pokemonImage.kf.indicatorType = .activity
        cell.pokemonImage.kf.setImage(with: tuple[indexPath.row].image)
        cell.type.text = tuple[indexPath.row].type
      }
      return cell
    } else {
      return UICollectionViewCell()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let numberOfItemsPerRow:CGFloat = 2
    let spacingBetweenCells:CGFloat = 20
    
    let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
    
    if let collection = self.pokeCollectionView{
      let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
      return CGSize(width: width, height: width + 100)
    } else {
      return CGSize(width: 0, height: 0)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let detailsVC = storyboard?.instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
      detailsVC.modalPresentationStyle = .overFullScreen
      detailsVC.nameData = tuple[indexPath.row].name
      detailsVC.typeData = tuple[indexPath.row].type
      detailsVC.imageURL = tuple[indexPath.row].image
      detailsVC.heightData = tuple[indexPath.row].height
      detailsVC.weaknessData = tuple[indexPath.row].weakness
      detailsVC.weightData = tuple[indexPath.row].weight
      for i in 0..<tuple.count {
        if tuple[indexPath.row].next_evolution?.count == 2 {
          if tuple[i].num  == tuple[indexPath.row].next_evolution?[0].num {
            detailsVC.ev1 = tuple[i].image
            detailsVC.ev1Name = tuple[i].name
            detailsVC.nextEVLabelText = "Next Evoution"
          }
          if tuple[i].num  == tuple[indexPath.row].next_evolution?[1].num {
            detailsVC.ev2 = tuple[i].image
            detailsVC.ev2Name = tuple[i].name

          }
        } else {
          if tuple[i].num  == tuple[indexPath.row].next_evolution?[0].num {
            detailsVC.ev1 = tuple[i].image
            detailsVC.ev1Name = tuple[i].name
            detailsVC.nextEVLabelText = "Next Evoution"

          }
        }
      }
      if tuple[indexPath.row].next_evolution == nil {
        detailsVC.nextEVLabelText = "No More Evoution"
      }
      present(detailsVC, animated: true, completion: nil)
    }
  }
}


extension HomeVC: UIViewControllerPreviewingDelegate {
  func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
    guard let indexPath = pokeCollectionView?.indexPathForItem(at: location) else { return nil}
    
    guard let cell = pokeCollectionView?.cellForItem(at: indexPath) as? PokemonCollectionViewCell else { return nil}
    
    if let detailsVC =  storyboard?.instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
      detailsVC.modalPresentationStyle = .overFullScreen
      detailsVC.nameData = tuple[indexPath.row].name
      detailsVC.typeData = tuple[indexPath.row].type
      detailsVC.imageURL = tuple[indexPath.row].image
      detailsVC.heightData = tuple[indexPath.row].height
      detailsVC.weaknessData = tuple[indexPath.row].weakness
      detailsVC.weightData = tuple[indexPath.row].weight
      for i in 0..<tuple.count {
        if tuple[indexPath.row].next_evolution?.count == 2 {
          if tuple[i].num  == tuple[indexPath.row].next_evolution?[0].num {
            detailsVC.ev1 = tuple[i].image
            detailsVC.ev1Name = tuple[i].name
          }
          if tuple[i].num  == tuple[indexPath.row].next_evolution?[1].num {
            detailsVC.ev2 = tuple[i].image
            detailsVC.ev2Name = tuple[i].name          }
        } else {
          if tuple[i].num  == tuple[indexPath.row].next_evolution?[0].num {
            detailsVC.ev1 = tuple[i].image
            detailsVC.ev1Name = tuple[i].name
          }
        }
      }
      if tuple[indexPath.row].next_evolution == nil {
        detailsVC.nextEVLabelText = "No More Evoution"
      }
      detailsVC.preferredContentSize = (detailsVC.view.frame.size)
      previewingContext.sourceRect = cell.frame
      return detailsVC
    } else {
      return UIViewController()
    }
  }
  
  func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
    show(viewControllerToCommit, sender: self)
  }
}
