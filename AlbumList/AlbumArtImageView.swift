//
//  AlbumArtImageView.swift
//  AlbumList
//
//  Created by Abin Baby on 27/10/20.
//

import TinyConstraints
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class AlbumArtImageView: UIImageView {

    var task: URLSessionTask!
    let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)

    func loadImage(from url: URL) {
        image = nil

        addSpinner()

        if let task: URLSessionTask = task {
            task.cancel()
        }

        if let imageFromCache: UIImage = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            removeSpinner()
            return
        }

        task = URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(( _, let data)):
                guard let albumArtImage = UIImage(data: data, scale: 1) else {
                    return
                }

                imageCache.setObject(albumArtImage, forKey: url.absoluteString as AnyObject)

                DispatchQueue.main.async {
                    self.image = albumArtImage
                    self.removeSpinner()
                }
            case .failure(let error):
                print("image loading failed--->", error)
             }
        }

        task.resume()
    }

    func addSpinner() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false

        // TODO - ask sami
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        spinner.startAnimating()
    }

    func removeSpinner() {
        spinner.removeFromSuperview()
    }
}
