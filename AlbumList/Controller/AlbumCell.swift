//
//  AlbumCell.swift
//  AlbumList
//
//  Created by Abin Baby on 27/10/20.
//

import TinyConstraints
import UIKit

class AlbumCell: UITableViewCell {
    var safeArea: UILayoutGuide!
    let albumArtImageView: AlbumArtImageView = AlbumArtImageView()
    let nameLabel: UILabel = UILabel()
    let artistLabel: UILabel = UILabel()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    func setupView() {
        safeArea = layoutMarginsGuide
        setupImageView()
        setupNameLabel()
        setupArtistLabel()
    }

    func setupImageView() {
        addSubview(albumArtImageView)
        albumArtImageView.translatesAutoresizingMaskIntoConstraints = false
        albumArtImageView.leading(to: safeArea)
        albumArtImageView.centerY(to: self.contentView)
        albumArtImageView.width(40)
        albumArtImageView.height(40)
    }

    func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.leadingToTrailing(of: albumArtImageView, offset: 10)
        nameLabel.top(to: self.contentView, offset: 5)
        nameLabel.trailing(to: safeArea, offset: -10)
        nameLabel.height(50)
        nameLabel.contentMode = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.numberOfLines = 2
    }

    func setupArtistLabel() {
        addSubview(artistLabel)
        artistLabel.translatesAutoresizingMaskIntoConstraints = false

        artistLabel.leading(to: nameLabel)
        artistLabel.trailing(to: nameLabel)
        artistLabel.topToBottom(of: nameLabel, offset: 2)
        artistLabel.bottom(to: safeArea, offset: -5)
        artistLabel.height(10)
        artistLabel.contentMode = .center
        artistLabel.font = UIFont.systemFont(ofSize: 13)
    }
}
