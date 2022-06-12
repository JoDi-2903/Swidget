//
//  IntentHandler.swift
//  SwidgetIntents
//
//  Created by Jonathan Diebel on 12.06.22.
//

import Intents

class IntentHandler: INExtension { //, ConfigurationIntentHandling
    
    func provideCategoriesTypeOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<CategoriesType>?, Error?) -> Void) {

        let symbols: [CategoriesType] = [
            CategoriesType(identifier: "top_rated", display: "Top Rated"),
            CategoriesType(identifier: "popular", display: "Popular"),
            CategoriesType(identifier: "now_playing", display: "Now Playing"),
            CategoriesType(identifier: "upcoming", display: "Upcoming")
        ]
        
            // Create a collection with the array of characters.
            let collection = INObjectCollection(items: symbols)

            // Call the completion handler, passing the collection.
            completion(collection, nil)
        }
    
}
