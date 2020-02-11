//
//  AlbumController.swift
//  iOS13-Albums
//
//  Created by Austin Potts on 2/10/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class AlbumController {
 
    func testDecodingExampleAlbum() {
    let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    let decoder = JSONDecoder()
    do {
       let album = try decoder.decode(Album.self, from: data)
        print(album)
    } catch {
        NSLog("Error decoding album")
    }
  }
}
