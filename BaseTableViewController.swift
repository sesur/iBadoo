//
//  BaseTableViewController.swift
//  iBadoo
//
//  Created by Sergiu on 8/14/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import UIKit

class BaseTableViewController<T: BasicCell<S>, S>: UITableViewController {
    let cellId = "cellId"
   
    var items = [S]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(T.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BasicCell<S>
        cell.cellItem = items[indexPath.row]
        
        return cell
    }
}


class BasicCell<U>: UITableViewCell {
    
    var cellItem: U!
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .orange
    }
}






struct Dog {
    let name: String
}

class DogCell: BasicCell<Dog> {
    override var cellItem: Dog! {
        didSet {
            textLabel?.text = cellItem.name
        }
    }
}



class SergiuController: BaseTableViewController<DogCell, Dog> {
    override func viewDidLoad() {
        super.viewDidLoad()
       items = [Dog(name: "grivei"),
                Dog(name: "ceaica"),
                Dog(name: "donald")]
    }
}

