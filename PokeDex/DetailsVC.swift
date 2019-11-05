//
//  DetailsVC.swift
//  PokeDex
//
//  Created by Jai Nijhawan on 01/11/19.
//  Copyright © 2019 Jai Nijhawan. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController {
  
 // var pokemonDetail: PokemonDetailModel!
  
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var type: UILabel!
  @IBOutlet weak var pokemonImage: UIImageView!
  @IBOutlet weak var weakness: UILabel!
  @IBOutlet weak var height: UILabel!
  @IBOutlet weak var weight: UILabel!
  @IBOutlet weak var EV1: UIImageView!
  @IBOutlet weak var EV2: UIImageView!
  @IBOutlet weak var nextEVLabel: UILabel!
  @IBOutlet weak var ev1Label: UILabel!
  @IBOutlet weak var ev2Label: UILabel!
  @IBOutlet weak var mainStackView: UIStackView!
  @IBOutlet weak var mainImageWidth: NSLayoutConstraint!
  
  var nameData: String?
  var typeData: String?
  var imageURL: URL?
  var heightData: String?
  var weightData: String?
  var weaknessData: String?
  var ev1: URL?
  var ev2: URL?
  var nextEVLabelText: String?
  var ev1Name: String?
  var ev2Name: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    
  }
  
  override func viewWillAppear(_ animated: Bool) {
//    name.text = pokemonDetail.name
//    type.text = pokemonDetail.type
    name.text = nameData
    type.text = typeData
    pokemonImage.kf.setImage(with: imageURL)
    weakness.text = weaknessData
    height.text = heightData
    weight.text = weightData
    EV1.kf.setImage(with: ev1)
    EV2.kf.setImage(with: ev2)
    nextEVLabel.text = nextEVLabelText
    mainImageWidth.constant = self.view.frame.width*0.5
    ev1Label.text = ev1Name
    ev2Label.text = ev2Name
    mainStackView.spacing = (self.view.frame.height - mainStackView.frame.maxY)*0.4

  }
  
  @IBAction func backPressed(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
