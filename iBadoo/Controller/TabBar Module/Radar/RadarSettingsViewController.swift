//
//  RadarSettingsViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class RadarSettingsViewController: UIViewController {
    
    private let radarSettingsView: RadarSettingsView = {
        let view = RadarSettingsView()
        return view
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupMainStackView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        hideNavigationTabBar(false)
        ///
        if let customTabBar = self.tabBarController as? CustomTabBarController {
            customTabBar.animationTabBarHidden(false)
        }
        
    }
    private func setupNavigation() {
        navigationItem.title = "Radar Settings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "done"), style: .done, target: self, action: #selector(handleDoneButtonTap))
    }
    
    //MARK:- Actions & Navigation
    @objc private func handleDoneButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Layouts
    private func setupMainStackView(){
        view.addSubview(radarSettingsView)
        radarSettingsView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 64, left: 0, bottom: 0, right: 0), size: .zero)
        
    }
}


