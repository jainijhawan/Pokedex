//
//  File.swift
//  PokeDex
//
//  Created by Jai Nijhawan on 28/10/19.
//  Copyright © 2019 Jai Nijhawan. All rights reserved.
//

import Foundation

struct DataModel: Codable {
  var pokemon: [DataStruct]
}

struct DataStruct: Codable {
  var num: String
  var name: String
  var img: URL
  var type: [String]
  var height: String
  var weight: String
  var weaknesses: [String]
  var next_evolution: [DataStruct2]?
  var prev_evolution: [DataStruct2]?
  //var prev_evolution: [DataStruct2]?
  
}
struct DataStruct2: Codable {
  var num: String
  var name: String
}
