//
//  DetailsViewController.swift
//  travelcar
//
//  Created by Fromage Charley on 06/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailsViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: CarFeatureCell.identifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: CarFeatureCell.identifier)
        }
    }

    public var car: Car?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupImage()
        setupEsquipments()
        setupTableView()
    }

    private func setupNavigationBar() {
        title = car?.make.capitalized
    }

    private func setupImage() {
        guard let car = car else { return }

        if let imageURL = URL(string: car.pictureURL) {
            imageView.af_setImage(withURL: imageURL)
        }
    }

    private func setupEsquipments() {
        car?.equipments?.forEach({ equipment in
            guard let equipment = Equipment(rawValue: equipment) else { return }

            stackView.addArrangedSubview(UIImageView(image: equipment.image))
        })
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CarFeature.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarFeatureCell.identifier, for: indexPath) as? CarFeatureCell else { return UITableViewCell() }

        if let feature = CarFeature(rawValue: indexPath.row),
           let car = car {
            switch feature {
                case .make: cell.setup(with: feature.text, and: car.make)
                case .model: cell.setup(with: feature.text, and: car.model)
                case .year: cell.setup(with: feature.text, and: String(car.year))
            }
        }

        return cell
    }
}
