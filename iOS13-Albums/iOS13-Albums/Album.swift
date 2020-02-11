//
//  Album.swift
//  iOS13-Albums
//
//  Created by Austin Potts on 2/10/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


struct Album: Codable {
    
    let name: String
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let songs: [Song]
    let id: String
    
    enum AlbumKeys: String, CodingKey {
       case artist
       case coverArt
       case genre
       case id
       case name
       case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        // Set up the Container
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        // Set up Container for nested UnKeyed
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtArray = [URL]()
        
        while coverArtContainer.isAtEnd == false {
            let coverArtUrlContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let url = try coverArtUrlContainer.decode(URL.self, forKey: .url)
            coverArtArray.append(url)
        }
        coverArt = coverArtArray
        
        genres = try container.decode([String].self, forKey: .genre)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        songs = try container.decode([Song].self, forKey: .songs)
    }
    
    
}


struct Song: Codable {
    let duration: String
    let id: String
    let name: String
    
    enum SongKeys: String, CodingKey {
        case durationDescription
        case id
        case name
        
        enum DurationsKey: String, CodingKey {
               case duration

           }
        enum NameKeys: String, CodingKey {
                       case title
                    }
    }
    
   
    
        
    init(from decoder: Decoder) throws {
        
        // Set up the Container
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationsKey.self, forKey: .durationDescription)
        
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        
        name = try nameContainer.decode(String.self, forKey: .title)
        
        
        //considered a single 
        id = try container.decode(String.self, forKey: .id)
    }
}

//name - album
//artist
//coverArt
//genres
//songs
//duration
