//
//  UIStackView+ArrangedSubiews.swift
//  AlbumList
//
//  Created by Abin Baby on 27/10/20.
//

import UIKit

extension UIStackView {
    func setArrangedSubviews(_ views: [UIView]) {
        removeAllSubviews()
        addArrangedSubviews(views)
    }

    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach(addArrangedSubview)
    }

    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
