//
//  FurnitureDealer.swift
//  Not A Shopping List
//
//  Created by Kenny on 12/20/19.
//  Copyright © 2019 Hazy Studios. All rights reserved.
//

import Foundation

class FurnitureDealer {
    
    var deskNames = [
        "Mahogany",
        "Oak",
        "Teak",
        "Cherry"
    ]
    
    var desks: [Desk] = []
    
    //MARK: Create
    func makeDesksNotWar() {
        loadFromPersistentStore()
        if desks.count == 0 {
            for name in deskNames {
                desks.append(Desk(name: name))
            }
        }
        saveToPersistentStore()
    }
    
    var fileLocation: URL? {
        let fileManager = FileManager.default
        //unwrap directory
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        //append books.plist to documentDirectory to create file at path (URL)
        let fileUrl = documentDirectory.appendingPathComponent("desks.plist")
        return fileUrl
    }
    
    var pickedDesks: [Desk] {
        return desks.filter {$0.wasTouched == true}
    }
    
    
    //MARK: Read
    func loadFromPersistentStore() {
        guard let fileURL = fileLocation else {return}
        
        do {
            let deskData = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            let deskArray = try decoder.decode([Desk].self, from: deskData)
            self.desks = deskArray
        } catch {
            print("Error loading desks from plist: \(error)")
        }
    }
    
    //MARK: Update
    func touchIt(forDesk desk: Desk) {
        if let index = desks.firstIndex(of: desk) {
            desks[index].wasTouched = !desks[index].wasTouched
            saveToPersistentStore()
        }
    }
    
    
    //MARK: Helper Methods
    private func saveToPersistentStore() {
        //check to make sure file url exists
        guard let fileURL = fileLocation else { return }
        do {
            let encoder = PropertyListEncoder()
            //use PList encoder to write desk file
            let desksData = try encoder.encode(desks)
            try desksData.write(to: fileURL)
        } catch {
            print("Error Saving books: \(error)")
        }
    }
}

