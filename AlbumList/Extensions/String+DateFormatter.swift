//
//  String+DateFormatter.swift
//  AlbumList
//
//  Created by Abin Baby on 28/10/20.
//

import Foundation

extension String {
    func formattedDateFromString(withInputFormat: String, outputFormat: String) -> String {
        let inputFormatter: DateFormatter = DateFormatter()
        inputFormatter.dateFormat = withInputFormat
        if let date: Date = inputFormatter.date(from: self) {
            let outputFormatter: DateFormatter = DateFormatter()
            outputFormatter.dateFormat = outputFormat
            return outputFormatter.string(from: date)
        }
        return self
    }
}
