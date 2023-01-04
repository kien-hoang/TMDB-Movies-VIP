//
//  String+Extensions.swift
//  
//
//  Created by Bradley Hoang on 28/12/2022.
//

import Foundation

extension String {
    var asTrimmed: String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func escape() -> String {
        let allowedCharacters = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return allowedCharacters
    }
}
