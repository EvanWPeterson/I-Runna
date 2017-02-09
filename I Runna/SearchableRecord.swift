//
//  SearchableRecord.swift
//  I Runna
//
//  Created by Evan Peterson on 1/26/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation

protocol SearchableRecord {
    func matchesSearchTerm(searchTerm: String) -> Bool 
    
}
