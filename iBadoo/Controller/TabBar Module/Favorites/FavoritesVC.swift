//
//  FavoritesVC.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let containerFavoritesView: FavoritesView = {
        let container = FavoritesView()
        return container
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLayouts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        //        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    private func setupNavigationBar() {
        navigationItem.title = "Favorites List"
        navigationController?.navigationBar.barTintColor = .mainBlue
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    //MARK:- Layouts
    private func setupLayouts() {
        view.addSubview(containerFavoritesView)
        containerFavoritesView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 64, left: 0, bottom: 0, right: 0), size: .zero)
    }
}
