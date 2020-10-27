//
//  Exceptions.swift
//  AlbumList
//
//  Created by Abin Baby on 26/10/20.
//

import Foundation

enum Exception: Error {
    case undefined
    case noResponse
    case noConnection
    case invalidFormat
    case notFound

    var description: String {
        switch self {
        case .undefined:
            return "Unknown error."
        case .noResponse:
            return "There are no albums right now"
        case .noConnection:
            return "Please check your internet connection"
        case .invalidFormat:
            return "We are having a problem in decoding the data received. Please try again later."
        case .notFound:
            return "Our server seems to be taking a break. Please try again later."
        default:
            return "Unknown error."
        }
    }
}
