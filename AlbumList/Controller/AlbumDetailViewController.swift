//
//  AlbumDetailViewController.swift
//  AlbumList
//
//  Created by Abin Baby on 27/10/20.
//

import SafariServices
import UIKit

class AlbumDetailViewController: UIViewController {

    var album: Album?
    var safeArea: UILayoutGuide!

    private lazy var albumArtImageView: AlbumArtImageView = {
        let imageView: AlbumArtImageView = AlbumArtImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var albumNameLabel: DetailLabel = {
        let albumNameLabel: DetailLabel = DetailLabel()
        albumNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return albumNameLabel
    }()

    private lazy var artistNameLabel: DetailLabel = {
        let artistNameLabel: DetailLabel = DetailLabel()
        artistNameLabel.font = UIFont.systemFont(ofSize: 13)
        artistNameLabel.textColor = .darkGray
        return artistNameLabel
    }()

    private lazy var genreLabel: DetailLabel = {
        let genreLabel: DetailLabel = DetailLabel()
        genreLabel.font = UIFont.boldSystemFont(ofSize: 13)
        genreLabel.textColor = .darkGray
        return genreLabel
    }()

    private lazy var releaseDateLabel: DetailLabel = {
        let releaseDateLabel: DetailLabel = DetailLabel()
        releaseDateLabel.font = UIFont.systemFont(ofSize: 13)
        releaseDateLabel.textColor = .gray
        return releaseDateLabel
    }()

    private lazy var copyrightLabel: DetailLabel = {
        let copyrightLabel: DetailLabel = DetailLabel()
        copyrightLabel.font = UIFont.systemFont(ofSize: 13)
        copyrightLabel.textColor = .lightGray
        return copyrightLabel
    }()

    private lazy var visitStoreButton: UIButton = {
        let storeButton: UIButton = UIButton()
        storeButton.backgroundColor = .clear
        storeButton.layer.cornerRadius = 5
        storeButton.layer.borderWidth = 1
        storeButton.layer.borderColor = UIColor.systemBlue.cgColor
        storeButton.setTitle("View in iTunes store", for: .normal)
        storeButton.setTitleColor(.systemBlue, for: .normal)
        storeButton.translatesAutoresizingMaskIntoConstraints = false
        return storeButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide

        setupView()

        setupData()

    }

    func setupView() {
        setupImageView()
        setupAlbumName()
        setupArtistName()
        setupGenre()
        setupReleaseDate()
        setupCopyright()
        setupStoreButton()
    }

    func setupImageView() {
        view.addSubview(albumArtImageView)
        albumArtImageView.centerX(to: view)
        albumArtImageView.top(to: safeArea, offset: 10)
        let halfScreenWidth: CGFloat = UIScreen.main.bounds.width * 0.5
        albumArtImageView.height(halfScreenWidth)
        albumArtImageView.width(halfScreenWidth)
    }

    func setupAlbumName() {
        view.addSubview(albumNameLabel)
        albumNameLabel.topToBottom(of: albumArtImageView, offset: 10)
        albumNameLabel.leading(to: safeArea, offset: 10)
        albumNameLabel.trailing(to: safeArea, offset: 10)
        albumNameLabel.centerX(to: safeArea)
    }

    func setupArtistName() {
        view.addSubview(artistNameLabel)
        artistNameLabel.topToBottom(of: albumNameLabel, offset: 5)
        artistNameLabel.leading(to: albumNameLabel)
        artistNameLabel.trailing(to: albumNameLabel)
        artistNameLabel.centerX(to: safeArea)
    }

    func setupGenre() {
        view.addSubview(genreLabel)
        genreLabel.topToBottom(of: artistNameLabel, offset: 2)
        genreLabel.leading(to: artistNameLabel)
        genreLabel.trailing(to: artistNameLabel)
        genreLabel.centerX(to: safeArea)
    }

    func setupReleaseDate() {
        view.addSubview(releaseDateLabel)
        releaseDateLabel.topToBottom(of: genreLabel, offset: 2)
        releaseDateLabel.leading(to: genreLabel)
        releaseDateLabel.trailing(to: genreLabel)
        releaseDateLabel.centerX(to: safeArea)
    }

    func setupCopyright() {
        view.addSubview(copyrightLabel)
        copyrightLabel.topToBottom(of: releaseDateLabel, offset: 2)
        copyrightLabel.leading(to: releaseDateLabel)
        copyrightLabel.trailing(to: releaseDateLabel)
        copyrightLabel.centerX(to: safeArea)
    }

    func setupData() {
        if let album: Album = album,
           let imageUrl: URL = URL(string: album.artworkUrl100) {
            albumArtImageView.loadImage(from: imageUrl)
            albumNameLabel.text = album.name
            artistNameLabel.text = album.artistName
            genreLabel.text = generateGenreLabel(from: album.genres)
            releaseDateLabel.text = generateReleaseDate(from: album.releaseDate)
            copyrightLabel.text = "Copyright \(album.copyright)"
        }
    }

    func setupStoreButton() {
        view.addSubview(visitStoreButton)

        visitStoreButton.leading(to: safeArea, offset: 20)
        visitStoreButton.trailing(to: safeArea, offset: -20)
        visitStoreButton.bottom(to: safeArea, offset: -20)
        visitStoreButton.centerX(to: view)
        visitStoreButton.height(40)

        visitStoreButton.addTarget(self,
                                   action: #selector(buttonAction),
                                   for: .touchUpInside)
    }

    @objc
    func buttonAction() {
        if let urlString: String = album?.url,
           let url: URL = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
                let safariViewController: SFSafariViewController = SFSafariViewController(url: url)
                navigationController?.present(safariViewController, animated: true)
            }
        }
    }

    // TODO: ask sami
    func generateGenreLabel(from genres: [Genre]) -> String {
        var genreString: String = "Genre: "
        for genre in genres {
            genreString.append("\(genre.name)"+", ")
        }

        return genreString
    }

    func generateReleaseDate(from dateString: String) -> String {
        let inputFormatter: DateFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        guard let releaseDate = inputFormatter.date(from: dateString) else {
            fatalError("Date format not found")
        }
        let outputFormatter: DateFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"
        let releaseDateString: String = outputFormatter.string(from: releaseDate)

        return "Released \(releaseDateString)"
    }
}