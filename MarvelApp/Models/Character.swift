//
//  Character.swift
//  MarvelApp
//
//  Created by Яна Преображенская on 17/07/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import Foundation

class ResponseData: Codable {
    var data : ResponseResult?
}

class ResponseResult: Codable {
    var results : [Character]?
}

class Character: Codable {
    var id : Int?
    var name : String?
    var description : String?
    var thumbnail : Thumbnail?
}

class Thumbnail : Codable {
    var path : String?
}
