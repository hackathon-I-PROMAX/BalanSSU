//
//  mainCategoriesResponse.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/25.
//

import Foundation

struct MainCategoriesResponse: Codable {
    
    let closedCategories: [closedCategoriesData]
    let hotCategories: [hotCategoriesData]
    
}

struct closedCategoriesData: Codable {
    
    let categoryId: String
    let dday: Int
    let participantCount: Int
    let title: String
    let type: String
    
}

struct hotCategoriesData: Codable {
    
    let categoryId: String
    let dday: Int
    let participantCount: Int
    let title: String
    let type: String
    
}

