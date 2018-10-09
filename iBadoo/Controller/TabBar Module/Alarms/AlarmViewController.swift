//
//  AlarmViewController.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/22/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    
    private let alarmView: AlarmView = {
        let alarm = AlarmView()
        return alarm
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupAlarmViewLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private func setupNavigationBar() {
        navigationItem.title = "Alarms"
        navigationController?.navigationBar.barTintColor = .mainBlue
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    //MARK:- Layouts
    private func setupAlarmViewLayout(){
        view.addSubview(alarmView)
        alarmView.fillSuperView()
    }
}
