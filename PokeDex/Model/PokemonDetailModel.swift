//
//  PokemonDetailModel.swift
//  PokeDex
//
//  Created by Jai Nijhawan on 01/11/19.
//  Copyright © 2019 Jai Nijhawan. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

struct Pokemon {
  var nameData: String
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
  
  init(name: String) {
    self.nameData = name
  }
}
