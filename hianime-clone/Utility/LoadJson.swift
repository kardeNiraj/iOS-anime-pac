//
//  Utility.swift
//  hianime-clone
//
//  Created by apple on 13/08/24.
//

import Foundation

// Example function to load JSON data from a file
func loadJSON<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
    else {
        print("No file found with name: \(filename)")
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    print("File found - \(filename)")
    
    do {
        data = try Data(contentsOf: file)
        print("contents copied in the data variable")
    } catch {
        print("Failed to copy contents in data with error: \(error)")
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        print("Decoding the data...")
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Failed to decode the data with error: \(error)")
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
