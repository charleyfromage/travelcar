//
//  AccountViewController.swift
//  travelcar
//
//  Created by Fromage Charley on 06/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupTabBarItem()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setupTabBarItem() {
        tabBarItem.title = ""
        tabBarItem.image = Assets.Profile.profileOff
        tabBarItem.selectedImage = Assets.Profile.profileOn
    }
}
