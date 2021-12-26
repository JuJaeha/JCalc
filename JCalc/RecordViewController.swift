//
//  RecordViewController.swift
//  JCalc
//
//  Created by JAEHA JU on 2021/11/04.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var recordTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recordTableView.delegate = self
        recordTableView.dataSource = self
        
        recordTableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "recordCell")
    }
}


extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecordTableViewCell = recordTableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordTableViewCell
        return cell
    }
}
