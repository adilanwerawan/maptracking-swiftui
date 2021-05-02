//
//  document-directory-files.swift
//  assign4
//
//  Created by Adil Anwer on 29/04/2021.
//

import Foundation


struct DocumentDirectoryFilesFunctions {
    
    static func documentDirectory() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                    .userDomainMask,
                                                                    true)
        return documentDirectory[0]
    }

    static func append(toPath path: String,
                        withPathComponent pathComponent: String) -> String? {
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(pathComponent)
            
            return pathURL.absoluteString
        }
        
        return nil
    }

    static func read(fromDocumentsWithFileName filePath: String) -> [GPXPoint]?{
//        guard let filePath = self.append(toPath: self.documentDirectory(),
//                                         withPathComponent: fileName) else {
//            return nil
//        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let decoder = JSONDecoder()
            let tracks = try! decoder.decode([GPXPoint].self, from: data)
            print("Here we print the json : ===---\(tracks)---")
            return tracks
        } catch {
            print(error)
        }
        return nil
    }

    static func save(toDirectory directory: String,
                      withFileName fileName: String, tracks:[GPXPoint]) {
        guard let filePath = self.append(toPath: directory,
                                         withPathComponent: fileName) else {
            return
        }
        
        do{
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let tracks = try! encoder.encode(tracks)
            try tracks.write(to: URL(fileURLWithPath: filePath))
        }catch{
            
        }
    }
}


