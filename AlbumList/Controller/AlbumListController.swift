//
//  AlbumListController.swift
//  AlbumList
//
//  Created by Abin Baby on 26/10/20.
//

import TinyConstraints
import UIKit

class AlbumListController: UIViewController {

    let tableView: UITableView = UITableView()
    var safeArea: UILayoutGuide!
    let cellIdentifier: String = "albumCell"

    var albumsList: [Album] = [Album]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide

        setupTableView()

        fetchAlbumLists()
    }

    // MARK: - Setup View
      func setupTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.top(to: safeArea)
        tableView.bottom(to: safeArea)
        tableView.edgesToSuperview(excluding: [.top, .bottom], usingSafeArea: false)

        tableView.register(AlbumCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.allowsSelection = false
      }

    // MARK: - API call
    func fetchAlbumLists() {
        AlbumAPI.sharedInstance.fetchAlbumsList { (result: Swift.Result<[Album], Exception>) in
            switch result {
            case .success(let dataArray):
                self.albumsList = dataArray
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure:
                print("failed")
            }
        }
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AlbumListController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albumsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        guard let albumCell = cell as? AlbumCell else {
            return cell
        }

        let album: Album = albumsList[indexPath.row]
        albumCell.nameLabel.text = album.name
        albumCell.artistLabel.text = album.artistName
        if let imageUrl: URL = URL(string: album.artworkUrl100) {
            albumCell.albumArtImageView.loadImage(from: imageUrl)
        }
        return cell
    }
}
