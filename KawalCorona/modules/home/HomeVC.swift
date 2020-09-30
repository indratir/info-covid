//
//  HomeVC.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 30/09/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, HomeViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    let headerIdentifier = "HeaderTitleCell"
    let summaryIdentifier = "SummaryCell"
    let provinceDataIdentifier = "ProvinceDataCell"
    let footerIdentifier = "FooterCell"
    
    var presenter: HomePresenterDelegate?
    var stickyHeaderView: ProvinceTabView?
    var data: HomeData? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedPatientType: PatientType = .recovered
    var selectedSegmentIndex: Int = 0
    var sections = [String]()
    
    let refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSections()
        tableView.register(UINib(nibName: headerIdentifier, bundle: nil), forCellReuseIdentifier: headerIdentifier)
        tableView.register(UINib(nibName: summaryIdentifier, bundle: nil), forCellReuseIdentifier: summaryIdentifier)
        tableView.register(UINib(nibName: provinceDataIdentifier, bundle: nil),
                           forCellReuseIdentifier: provinceDataIdentifier)
        tableView.register(UINib(nibName: footerIdentifier, bundle: nil), forCellReuseIdentifier: footerIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 70.0
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.tintColor = .systemRed
        tableView.insertSubview(refreshControl, at: 0)
        onRefresh()
    }
    
    @objc func onRefresh() {
        presenter?.getHomeData()
    }
    
    func setSections() {
        sections.append(headerIdentifier)
        sections.append(summaryIdentifier)
        sections.append(provinceDataIdentifier)
        sections.append(footerIdentifier)
    }
    
    func showHomeData(_ data: HomeData) {
        self.data = data
    }
    
    func showError(_ message: String) {
        let alertVC = UIAlertController(title: "Terjadi kesalahan", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Tutup", style: .cancel, handler: nil))
        
        self.present(alertVC, animated: true)
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case headerIdentifier, summaryIdentifier, footerIdentifier:
            return 1
        case provinceDataIdentifier:
            if let provinceDataCount = data?.provinces?.count {
                return provinceDataCount
            }
            
            return 10
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case headerIdentifier:
            if let cell = tableView.dequeueReusableCell(withIdentifier: headerIdentifier) as? HeaderTitleCell {
                cell.labelTitle.text = Date().greetingCaption
                
                return cell
            }
        case summaryIdentifier:
            if let cell = tableView.dequeueReusableCell(withIdentifier: summaryIdentifier) as? SummaryCell {
                cell.setData(dashboardData: data?.dashboard)
                
                return cell
            }
        case provinceDataIdentifier:
            if let cell = tableView.dequeueReusableCell(withIdentifier: provinceDataIdentifier) as? ProvinceDataCell {
                cell.setData(data?.provinces?[indexPath.row], type: selectedPatientType)
                
                return cell
            }
        case footerIdentifier:
            if let cell = tableView.dequeueReusableCell(withIdentifier: footerIdentifier) as? FooterCell {
            
                return cell
            }
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section] {
        case provinceDataIdentifier:
            stickyHeaderView = ProvinceTabView(frame: .zero)
            stickyHeaderView?.segmentedControl.selectedSegmentIndex = selectedSegmentIndex
            stickyHeaderView?.delegate = self
            
            return stickyHeaderView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section] {
        case provinceDataIdentifier:
            return 93.0
        default:
            return 0.0
        }
    }
}

extension HomeVC: MainViewDelegate {
    func changeProvinceData(type: PatientType, index: Int) {
        selectedPatientType = type
        selectedSegmentIndex = index
        if let section = sections.firstIndex(of: provinceDataIdentifier) {
            tableView.reloadSections([section], with: .automatic)
        }
    }
}
