//
//  AlbumCell.swift
//  AlbumList
//
//  Created by Abin Baby on 27/10/20.
//

import TinyConstraints
import UIKit

class AlbumCell: UITableViewCell {

    let albumArtImageView: AlbumArtImageView = {
        let imageView: AlbumArtImageView = AlbumArtImageView()
        imageView.height(60)
        imageView.width(60)
        return imageView
    }()

    private lazy var artistLabel: UILabel = {
        let artistLabel: UILabel = UILabel()
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.lineBreakMode = .byTruncatingTail
        artistLabel.contentMode = .center
        artistLabel.font = UIFont.systemFont(ofSize: 13)
        return artistLabel
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel: UILabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.contentMode = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.numberOfLines = 3
        nameLabel.lineBreakMode = .byTruncatingTail
        return nameLabel
    }()

    private lazy var labelStackView: UIStackView = {
        let verticalStackView: UIStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillProportionally
        verticalStackView.spacing = 3
        verticalStackView.alignment = .top
        verticalStackView.addArrangedSubviews([nameLabel, artistLabel])
        return verticalStackView
    }()

    private lazy var contentStackView: UIStackView = {
        let horizontalStackView: UIStackView = UIStackView()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillProportionally
        horizontalStackView.alignment = .center
        horizontalStackView.addArrangedSubviews([albumArtImageView, labelStackView])
        horizontalStackView.spacing = 10
        return horizontalStackView
    }()

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
        contentView.addSubview(contentStackView)
        contentStackView.leadingToSuperview(offset: 10)
        contentStackView.edgesToSuperview(excluding: .leading)
    }

    // MARK: - Display information

    func populateCell(with album: Album) {
        nameLabel.text = album.name
        artistLabel.text = album.artistName
        if let imageUrl: URL = URL(string: album.artworkUrl100) {
            albumArtImageView.loadImage(from: imageUrl)
        }
    }
}
