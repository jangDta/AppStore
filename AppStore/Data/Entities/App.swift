//
//  App.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/04.
//

import Foundation

// MARK: - Search App Response

struct SearchAppResponse: Codable {
    let resultCount: Int
    let results: [App]
}

// MARK: - App

struct App: Codable {
    let wrapperType: String?
    let kind: String?
    let artistID, collectionID, trackID: Int?
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let trackCensoredName: String?
    let collectionArtistID: Int?
    let collectionArtistName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let collectionArtistViewURL: String?
    let contentAdvisoryRating: String?
    let screenshotUrls: [String]?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case collectionArtistID = "collectionArtistId"
        case collectionArtistName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
        case collectionArtistViewURL = "collectionArtistViewUrl"
        case contentAdvisoryRating
        case screenshotUrls
    }
}

extension App {
    func toModel() -> AppModel {
        AppModel(artistName: self.artistName,
                 trackName: self.trackName,
                 artwork: self.artworkUrl100,
                 screenshotUrls: self.screenshotUrls)
    }
}
