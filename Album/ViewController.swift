//
//  ViewController.swift
//  Album
//
//  Created by solar on 17/4/7.
//  Copyright © 2017年 PigVillageStudio. All rights reserved.
//

import UIKit

// MARK: - tableview里每一条信息的内容结构体
struct data {
    var username:String
    var time:String
    var content:String
    var pictures:[String]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    // MARK: - 展示tableView
    @IBOutlet weak var tableView: UITableView!
    // MARK: - 信息数组
    var dataArray = [
        data(username: "aaa", time: "2017-1-1 11:00", content: "huihafifa", pictures: ["1.png","1.png"]),
        data(username: "bbb", time: "2017-1-1 11:00", content: "huihafifa", pictures: []),
        data(username: "ccc", time: "2017-1-1 11:00", content: "huihafifahuihafifahuihafifahuihafifahuihafifahuihafifahuihafifahuihafifahuihafhuihafifahuihafifahuihafifahuihafifahuihafifahuihafhuihafifahuihafifahuihafifahuihafifahuihafifahuihafhuihafifahuihafifahuihafifahuihafifahuihafifahuihafhuihafifahuihafifahuihafifahuihafifahuihafifahuihafhuihafifahuihafifahuihafifahuihafifahuihafifahuihafhuihafifahuihafifahuihafifahuihafifahuihafifahuihaf", pictures: ["1.png","1.png","1.png","1.png","1.png"]),
        data(username: "ddd", time: "2017-1-1 11:00", content: "huihafifahuihafifahuihafifahuihafifahuihafifahuihaf", pictures: ["1.png","1.png","1.png","1.png","1.png","1.png","1.png","1.png","1.png"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // MARK: - 继承的UITableView的delegate和dataSource
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // MARK: - 设置cell的默认高度
        self.tableView.estimatedRowHeight = 44.0
        // MARK: - 设置cell根据InfoTableViewCell高度而改变高度
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.view.addSubview(tableView)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UINib(nibName:"InfoTableViewCell", bundle:nil), forCellReuseIdentifier: "infoCell")
        let cell: InfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! InfoTableViewCell
        cell.selectionStyle = .none
        // MARK: - 设置cell的frame
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        cell.reloadData(userLogoImage: UIImage.init(named: "1.png")!, username: dataArray[indexPath.row].username, time: dataArray[indexPath.row].time, content: dataArray[indexPath.row].content, pictures: dataArray[indexPath.row].pictures)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

