//
//  APIResponse.swift
//  webService_Demo
//
//  Created by Mac on 08/04/25.
//

import Foundation

struct APIResponse{
    var carts : [Cart]
    var total :Int
    var skip : Int
    var limit : Int
}
