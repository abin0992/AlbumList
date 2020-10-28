//
//  DetailLabel.swift
//  AlbumList
//
//  Created by Abin Baby on 27/10/20.
//

import UIKit

class DetailLabel: UILabel {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    func setupLabel() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    }
}
