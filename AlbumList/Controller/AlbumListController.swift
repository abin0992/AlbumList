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
    var albumService: AlbumService = AlbumService()
    let loadingView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        safeArea = view.layoutMarginsGuide
        self.view.backgroundColor = .white

        addNavigationBar()
        setupLoadingView()
        setupTableView()

        fetchAlbumList()
    }

    // MARK: - Setup View

    private func addNavigationBar() {
        self.title = "Top trending"
        self.navigationController?.navigationBar.backgroundColor = .white
    }

    private func setupTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundView = loadingView
        tableView.top(to: safeArea)
        tableView.bottom(to: safeArea)
        tableView.edgesToSuperview(excluding: [.top, .bottom], usingSafeArea: false)

        tableView.register(AlbumCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 85
        tableView.tableFooterView = UIView(frame: .zero)
    }

    private func setupLoadingView() {
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()

        let loadingLabel: UILabel = UILabel()
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = .gray

        let loadingStackView: UIStackView = UIStackView()
        loadingView.addSubview(loadingStackView)
        loadingStackView.translatesAutoresizingMaskIntoConstraints = false
        loadingStackView.axis = .horizontal
        loadingStackView.distribution = .fillProportionally
        loadingStackView.alignment = .center
        loadingStackView.addArrangedSubviews([spinner, loadingLabel])
        loadingStackView.spacing = 10
        loadingStackView.centerInSuperview()
    }

    // MARK: - API call
    func fetchAlbumList() {
        albumService.fetchAlbumLists { (result: Swift.Result<AlbumList, Exception>) in
            switch result {
            case .success(let dataArray):
                self.albumsList = dataArray.feed.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.backgroundView = nil
                }
            case .failure:
                print("failed")
            }
        }
    }
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
        let selectedAlbum: Album = albumsList[indexPath.row]
        let detailViewController: AlbumDetailViewController = AlbumDetailViewController()
        detailViewController.album = selectedAlbum
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
