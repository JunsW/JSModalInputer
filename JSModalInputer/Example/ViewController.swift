//
//  ViewController.swift
//  JSModalInputer
//
//  Created by 王俊硕 on 2018/1/23.
//  Copyright © 2018年 王俊硕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UITableView!
    
    // Data Source
    var titles = ["Telephone","Address", "Bio"]
    var values = ["", "", ""]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupContentView() {
        
        contentView.delegate = self
        contentView.dataSource = self
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = values[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        InputerHelper.shared.reset(title: titles[indexPath.row], initialText: values[indexPath.row]) { (text) in
            self.values[indexPath.row] = text
            self.contentView.reloadData()
        }
        if indexPath.row == 0 { InputerHelper.shared.inputerKeyboardType = .numberPad }
        InputerHelper.shared.show(On: self)
    }
}

class InputerHelper {
    static let shared = JSModalInputer(title: "")
    private init() {}
    
    
    
}

