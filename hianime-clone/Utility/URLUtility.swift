//
//  URLUtility.swift
//  hianime-clone
//
//  Created by apple on 23/08/24.
//

import Foundation

class URLUtility {
    static func urlEncode(_ parameters: [(String, String, Bool)]) -> String {
        return parameters.map { pair in
            let key = pair.0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            let value = pair.2 ? pair.1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "" : pair.1
            
            return "\(key)=\(value)"
        }.joined(separator: "&")
    }
    
    static func urlEncodeGenres(from genres: [String]) -> String? {
        let joinedGenres = genres.joined(separator: ",")
        return joinedGenres.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
