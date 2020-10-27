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

        safeArea = view.layoutMarginsGuide
        self.view.backgroundColor = .white

        addNavigationBar()
        setupTableView()

        fetchAlbumLists()
    }

    // MARK: - Setup View

    private func addNavigationBar() {
        self.title = "Top trending"
        self.navigationController?.navigationBar.backgroundColor = .white
    }

    private func setupTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.top(to: safeArea)
        tableView.bottom(to: safeArea)
        tableView.edgesToSuperview(excluding: [.top, .bottom], usingSafeArea: false)

        tableView.register(AlbumCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 85
    }

    // MARK: - API call
    private func fetchAlbumLists() {
        NetworkManager.sharedInstance.fetch { (result: Swift.Result<AlbumList, Exception>) in
            switch result {
            case .success(let dataArray):
                self.albumsList = dataArray.feed.results
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

extension AlbumListController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albumsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AlbumCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AlbumCell ?? AlbumCell()

        let album: Album = albumsList[indexPath.row]
        cell.populateCell(with: album)
        return cell
    }

    // MARK: - Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAlbum = albumsList[indexPath.row]
        let detailViewController: AlbumDetailViewController = AlbumDetailViewController()
        detailViewController.album = selectedAlbum
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
