//
//  ListViewController.swift
//  travelcar
//
//  Created by Fromage Charley on 06/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewAnimation {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: CarCell.identifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: CarCell.identifier)
        }
    }

    private var cars = [Car]() {
        didSet {
            tableView.reloadData()
            show(tableView)
        }
    }

    private var filteredCars: [Car] {
        return cars.filter { (car: Car) -> Bool in
            guard let searchText = searchController.searchBar.text else { return true }

            return car.make.lowercased().contains(searchText.lowercased())
        }
    }

    private let searchController = UISearchController(searchResultsController: nil)
    private var isFiltering = false
    private var isSearchEmpty: Bool {
        return searchController.searchBar.text?.count == 0
    }

    private var selectedCarIndex: Int?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupNavigationBarItem()
        setupTabBarItem()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTabBar()
        setupSearchController()
        setupTableView()

        fetchCars()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.pushToDetails {
            if let detailsViewController = segue.destination as? DetailsViewController {
                guard let selectedCarIndex = selectedCarIndex else { return }

                detailsViewController.car = cars[selectedCarIndex]
            }
        }
    }

    private func fetchCars() {
        let services = Services()

        services.getCarsList { [weak self] cars, error in
            self?.cars = cars
        }
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
    }

    private func setupNavigationBarItem() {
        title = Strings.List.title.capitalized
    }

    private func setupTabBar() {
        navigationController?.tabBarController?.tabBar.tintColor = .black
    }

    private func setupTabBarItem() {
        navigationController?.tabBarItem.title = ""
        navigationController?.tabBarItem.image = Assets.List.searchOff
        navigationController?.tabBarItem.selectedImage = Assets.List.searchOn
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Strings.List.searchBarPlaceholder
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isFiltering && !isSearchEmpty) ? filteredCars.count : cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarCell.identifier, for: indexPath) as? CarCell else { return UITableViewCell() }

        let car = (isFiltering && !isSearchEmpty) ? filteredCars[indexPath.row] : cars[indexPath.row]
        let searchText = searchController.searchBar.text

        cell.setup(with: car, and: searchText)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCarIndex = indexPath.row

        performSegue(withIdentifier: Constants.Segues.pushToDetails, sender: self)
    }
}

extension ListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        isFiltering = true
        tableView.reloadData()

        tabBarItem.title = searchController.searchBar.text
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
    }
}
