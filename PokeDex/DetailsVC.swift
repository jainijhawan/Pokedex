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
  
  var pokemonDetail: Pokemon!
  
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
  @IBOutlet weak var upperStackView: UIStackView!
  @IBOutlet weak var imageStackView: UIStackView!
  @IBOutlet weak var middleStackView: UIStackView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    name.text = pokemonDetail.nameData
     type.text = pokemonDetail.typeData
     pokemonImage.kf.setImage(with: pokemonDetail.imageURL)
     weakness.text = pokemonDetail.weaknessData
     height.text = pokemonDetail.heightData
     weight.text = pokemonDetail.weightData
     EV1.kf.setImage(with: pokemonDetail.ev1)
     EV2.kf.setImage(with: pokemonDetail.ev2)
     nextEVLabel.text = pokemonDetail.nextEVLabelText
     ev1Label.text = pokemonDetail.ev1Name
     ev2Label.text = pokemonDetail.ev2Name
     mainStackView.spacing = (self.view.frame.height - mainStackView.frame.maxY)*0.4
    upperStackView.spacing = (self.view.frame.height - mainStackView.frame.maxY)*0.1
    middleStackView.spacing = (self.view.frame.height - mainStackView.frame.maxY)*0.03
  }
  
  @IBAction func backPressed(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
