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
    let albumArtImageView: AlbumArtImageView = AlbumArtImageView()
    let albumNameLabel: UILabel = UILabel()
    let artistNameLabel: UILabel = UILabel()
    let genreLabel: UILabel = UILabel()
    let releaseDateLabel: UILabel = UILabel()
    let copyrightLabel: UILabel = UILabel()
    let visitStoreButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupImageView()
        setupAlbumName()
        setupArtistName()
        setupGenre()
        setupReleaseDate()
        setupCopyright()
        setupData()
        setupStoreButton()
    }

    func setupImageView() {
        view.addSubview(albumArtImageView)
        albumArtImageView.translatesAutoresizingMaskIntoConstraints = false
        albumArtImageView.centerX(to: view)
        albumArtImageView.top(to: view, offset: 100)
        let halfScreenWidth: CGFloat = UIScreen.main.bounds.width * 0.5
        albumArtImageView.height(halfScreenWidth)
        albumArtImageView.width(halfScreenWidth)
        albumArtImageView.contentMode = .scaleAspectFit
    }

    func setupAlbumName() {
        view.addSubview(albumNameLabel)
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.topToBottom(of: albumArtImageView, offset: 10)
        albumNameLabel.leading(to: safeArea, offset: 10)
        albumNameLabel.trailing(to: safeArea, offset: 10)

        albumNameLabel.contentMode = .center
        albumNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        albumNameLabel.numberOfLines = 0
        albumNameLabel.lineBreakMode = .byWordWrapping
        albumNameLabel.centerX(to: view)
    }

    func setupArtistName() {
        view.addSubview(artistNameLabel)
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.topToBottom(of: albumNameLabel, offset: 5)
        artistNameLabel.leading(to: albumNameLabel)
        artistNameLabel.trailing(to: albumNameLabel)

        artistNameLabel.contentMode = .center
        artistNameLabel.font = UIFont.systemFont(ofSize: 13)
        artistNameLabel.textColor = .darkGray
        artistNameLabel.numberOfLines = 0
        artistNameLabel.lineBreakMode = .byWordWrapping
        artistNameLabel.centerX(to: view)
    }
    func setupGenre() {
        view.addSubview(genreLabel)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.topToBottom(of: artistNameLabel, offset: 2)
        genreLabel.leading(to: artistNameLabel)
        genreLabel.trailing(to: artistNameLabel)

        genreLabel.contentMode = .center
        genreLabel.font = UIFont.boldSystemFont(ofSize: 13)
        genreLabel.textColor = .darkGray
        genreLabel.numberOfLines = 0
        genreLabel.lineBreakMode = .byWordWrapping
        genreLabel.centerX(to: view)
    }

    func setupReleaseDate() {
        view.addSubview(releaseDateLabel)
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.topToBottom(of: genreLabel, offset: 2)
        releaseDateLabel.leading(to: genreLabel)
        releaseDateLabel.trailing(to: genreLabel)

        releaseDateLabel.contentMode = .center
        releaseDateLabel.font = UIFont.systemFont(ofSize: 13)
        releaseDateLabel.textColor = .gray
        releaseDateLabel.numberOfLines = 0
        releaseDateLabel.lineBreakMode = .byWordWrapping
        releaseDateLabel.centerX(to: view)
    }

    func setupCopyright() {
        view.addSubview(copyrightLabel)
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.topToBottom(of: releaseDateLabel, offset: 2)
        copyrightLabel.leading(to: releaseDateLabel)
        copyrightLabel.trailing(to: releaseDateLabel)

        copyrightLabel.contentMode = .center
        copyrightLabel.font = UIFont.systemFont(ofSize: 13)
        copyrightLabel.textColor = .lightGray
        copyrightLabel.numberOfLines = 0
        copyrightLabel.lineBreakMode = .byWordWrapping
        copyrightLabel.centerX(to: view)
    }

    func setupData() {
        if let album: Album =  album,
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
        visitStoreButton.translatesAutoresizingMaskIntoConstraints = false

        visitStoreButton.leading(to: safeArea, offset: 20)
        visitStoreButton.trailing(to: safeArea, offset: 20)
        visitStoreButton.bottom(to: safeArea, offset: 20)
        visitStoreButton.centerX(to: view)
        visitStoreButton.height(40)

        visitStoreButton.backgroundColor = .lightGray
        visitStoreButton.setTitle("View in iTunes store", for: .normal)
        visitStoreButton.setTitleColor(.systemBlue, for: .normal)
        visitStoreButton.addTarget(self,
                                   action: #selector(buttonAction),
                                   for: .touchUpInside)
    }

    @objc
    func buttonAction() {
        if let urlString = album?.url,
           let url = URL(string: urlString) {
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
