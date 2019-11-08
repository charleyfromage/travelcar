//
//  ProfileViewController.swift
//  travelcar
//
//  Created by Fromage Charley on 06/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import UIKit

enum ProfileSection: Int, CaseIterable {
    case firstName
    case lastName
    case address
    case birthDate

    var text: String {
        switch self {
            case .firstName: return Strings.Profile.firstName
            case .lastName: return Strings.Profile.lastName
            case .address: return Strings.Profile.address
            case .birthDate: return Strings.Profile.birthDate
        }
    }

    var placeholder: String? {
        switch self {
            case .firstName: return Strings.Profile.firstNamePlaceholder
            case .lastName: return Strings.Profile.lastNamePlaceholder
            case .address: return Strings.Profile.addressPlaceholder
            case .birthDate: return Strings.Profile.birthDatePlaceholder
        }
    }
}

class ProfileViewController: UIViewController {
    @IBOutlet private weak var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var editPistureButton: UIButton!
    @IBOutlet private weak var saveProfileButton: UIButton!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: ProfileCell.identifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: ProfileCell.identifier)
        }
    }

    var profile = Profile() {
        didSet {
            tableView.visibleCells.forEach { cell in
                guard let cell = cell as? ProfileCell,
                      let section = cell.section
                else { return }

                cell.setup(with: section, and: profile)
            }
        }
    }
    
    let datePicker = UIDatePicker()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupTabBarItem()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let profileData = UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.profile) as? Data {
            let decoder = JSONDecoder()
            if let profile = try? decoder.decode(Profile.self, from: profileData) {
                self.profile = profile
            }
        }

        setupTapGestureRecongizer()
        setupImageView()
        setupProfilePicture()
        setupEditProfilePictureButton()
        setupTableView()
        setupSaveButton()
        setupDatePicker()
    }

    private func setupTabBarItem() {
        tabBarItem.title = ""
        tabBarItem.image = Assets.Profile.profileOff
        tabBarItem.selectedImage = Assets.Profile.profileOn
    }

    private func setupTapGestureRecongizer() {
        tapGestureRecognizer.addTarget(self, action: #selector(dismissTapped))
    }

    private func setupImageView() {
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
    }

    private func setupProfilePicture() {
        imageView.image = profile.photo ?? Assets.Profile.profileOff
    }

    private func setupEditProfilePictureButton() {
        editPistureButton.layer.borderColor = UIColor.black.cgColor
        editPistureButton.layer.borderWidth = 1
        editPistureButton.layer.cornerRadius = editPistureButton.frame.height/2
        editPistureButton.clipsToBounds = true
        editPistureButton.backgroundColor = .white
        editPistureButton.tintColor = .black
        editPistureButton.setImage(Assets.Profile.editProfilePicture, for: .normal)
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    private func setupSaveButton() {
        saveProfileButton.tintColor = .black
        saveProfileButton.setTitle(Strings.Profile.save, for: .normal)
    }

    private func setupDatePicker() {
        datePicker.date = profile.birthDate ?? Date()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateValueChanged(sender:)), for: .valueChanged)
    }

    @IBAction func editProfilePictureTapped() {
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: Strings.Profile.fromCamera, style: .default, handler: { [weak self] _ in
            imagePicker.sourceType = .camera
            self?.present(imagePicker, animated: true, completion: nil)
        }))

        alertController.addAction(UIAlertAction(title: Strings.Profile.fromPhotos, style: .default, handler: { [weak self] _ in
            imagePicker.sourceType = .photoLibrary
            self?.present(imagePicker, animated: true, completion: nil)
        }))

        alertController.addAction(UIAlertAction(title: Strings.Common.cancel, style: .cancel, handler: nil))

        present(alertController, animated: true)
    }

    @objc func dateValueChanged(sender: UIDatePicker) {
        profile.birthDate = datePicker.date
    }

    @objc private func dismissTapped() {
        view.endEditing(true)
    }

    @IBAction func saveProfile() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(profile) {
            UserDefaults.standard.set(encoded, forKey: Constants.UserDefaultsKeys.profile)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileSection.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as? ProfileCell else { return UITableViewCell() }

        if let section = ProfileSection(rawValue: indexPath.row) {
            cell.setup(with: section, and: profile)
            cell.textField.delegate = self

            if section == .birthDate {
                cell.textField.inputView = datePicker
            }
        }

        return cell
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            imageView.image = image
            profile.photo = image
        }

        dismiss(animated: true)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.visibleCells.forEach { cell in
            guard let cell = cell as? ProfileCell else { return }

            if cell.textField == textField {
                let newValue = textField.text != "" ? textField.text : nil

                switch cell.section {
                    case .firstName: profile.firstName = newValue
                    case .lastName: profile.lastName = newValue
                    case .address: profile.address = newValue

                    default: break
                }
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.inputView != datePicker {
            textField.resignFirstResponder()
        }

        return true
    }
}
