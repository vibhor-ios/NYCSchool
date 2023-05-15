//
//  SchoolListVC.swift
//  20230512-VibhorSingla-NYCSchools
//
//  Created by Vibhor Singla on 12/05/23.
//

import Foundation
import UIKit
class SchoolListVC: UIViewController {

    @IBOutlet weak var tblViewSchoolList: UITableView!
    
    private var schoolListVm = SchoolListVM()
    var schoolList = [SchoolListModel]()
    var networkStatus = ""
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        checkNetwork()
        schoolListVm.schoolListVmDelegate = self
        pullToRefresh()
    }

}

extension SchoolListVC: UITableViewDelegate, UITableViewDataSource, SchoolListVMDelegate {
    func didReceiveSchoolListResponse(schoolListResponse: [SchoolListModel]?, err: NetworkError?) {
        if err != nil, let error = err {
            Alert(message: error.localizedDescription)
        } else if let response = schoolListResponse {
            schoolList = response
            DispatchQueue.main.async {
                self.tblViewSchoolList.reloadSections(IndexSet(integer: 0), with: .fade)
                //self.tblViewSchoolList.reloadData()
            }
        }
    }
    
    
    func registerXib() {
        tblViewSchoolList.register(UINib(nibName: Cell.schoolCell, bundle: nil), forCellReuseIdentifier: Cell.schoolCell)
    }
    
    // for performing pull to refresh
    fileprivate func pullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblViewSchoolList.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        if self.networkStatus == "Offline" {
            Alert(message: Constants.netConnection)
            self.refreshControl.endRefreshing()
        } else {
            schoolListVm.getSchoolList()
            self.refreshControl.endRefreshing()
        }
    }
    
    // for checking the network connectivity
    fileprivate func checkNetwork() {
        switch status {
        case .unknown, .offline:
            print("Not connected")
        case .online(.wwan):
            print("Connected via WWAN")
        case .online(.wiFi):
            print("Connected via WiFi")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(SchoolListVC.networkStatusChanged(_:)), name: Notification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        
        Reach().monitorReachabilityChanges()
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let status = userInfo["Status"] as! String
            self.networkStatus = status
            if status == "Offline" {
                AlertWithOneOption(message: Constants.netConnection, optionOne: "Refresh") {
                    self.pullToRefresh()
                }
            } else {
                schoolListVm.getSchoolList()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.schoolCell) as! SchoolCell
        cell.schoolDetails = schoolList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Storyboards.Main(controller: Controller.schoolDetailsVC) as! SchoolDetailsVC
        vc.dbn = schoolList[indexPath.row].dbn
        vc.schoolDetail = schoolList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
