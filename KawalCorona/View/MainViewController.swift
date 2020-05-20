//
//  MainViewController.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 10/05/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var covidIndonesiaService: CovidIndonesiaService!
    var covidIndonesiaProvinceService: CovidIndonesiaProvinceService!
    
    let headerIdentifier = "HeaderTitleCell"
    let summaryIdentifier = "SummaryCell"
    let provinceDataIdentifier = "ProvinceDataCell"
    let footerIdentifier = "FooterCell"
    
    var sections = [String]()
    var dashboardData: DashboardData?
    var provinceData: [ProvinceAttribute]?
    var provinceDataIsLoaded: Bool = false
    var selectedPatientType: PatientType = .recovered
    var selectedSegmentIndex: Int = 0
    var stickyHeaderView: ProvinceTabView?
    
    let refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        covidIndonesiaService = CovidIndonesiaService(delegate: self)
        covidIndonesiaProvinceService = CovidIndonesiaProvinceService(delegate: self)
        
        setSections()
        tableView.register(UINib(nibName: headerIdentifier, bundle: nil), forCellReuseIdentifier: headerIdentifier)
        tableView.register(UINib(nibName: summaryIdentifier, bundle: nil), forCellReuseIdentifier: summaryIdentifier)
        tableView.register(UINib(nibName: provinceDataIdentifier, bundle: nil), forCellReuseIdentifier: provinceDataIdentifier)
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
        self.covidIndonesiaService.load()
        self.covidIndonesiaProvinceService.load()
    }
    
    func setSections() {
        sections.append(headerIdentifier)
        sections.append(summaryIdentifier)
        sections.append(provinceDataIdentifier)
        sections.append(footerIdentifier)
    }
}

extension MainViewController: CovidIndonesiaDelegate {
    func onLoaded(responseObject: DashboardData) {
        self.refreshControl.endRefreshing()
        self.dashboardData = responseObject
        if let section = sections.firstIndex(of: summaryIdentifier) {
            tableView.reloadSections([section], with: .automatic)
        }
    }
    
    func onError(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alertVC, animated: true)
    }
}

extension MainViewController: CovidIndonesiaProvinceDelegate {
    func onLoaded(response: [ProvinceAttribute]) {
        self.refreshControl.endRefreshing()
        self.provinceData = response
        if let section = sections.firstIndex(of: provinceDataIdentifier) {
            self.provinceDataIsLoaded = true
            tableView.reloadSections([section], with: .automatic)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case headerIdentifier, summaryIdentifier, footerIdentifier:
            return 1
        case provinceDataIdentifier:
            return provinceDataIsLoaded ? (provinceData?.count ?? 0) : 10
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case headerIdentifier:
            let cell = tableView.dequeueReusableCell(withIdentifier: headerIdentifier) as! HeaderTitleCell
            cell.labelTitle.text = Date().greetingCaption
            
            return cell
        case summaryIdentifier:
            let cell = tableView.dequeueReusableCell(withIdentifier: summaryIdentifier) as! SummaryCell
            cell.setData(dashboardData: dashboardData)
            
            return cell
        case provinceDataIdentifier:
            let cell = tableView.dequeueReusableCell(withIdentifier: provinceDataIdentifier) as! ProvinceDataCell
            cell.setData(provinceData?[indexPath.row], type: selectedPatientType)
            
            return cell
        case footerIdentifier:
            let cell = tableView.dequeueReusableCell(withIdentifier: footerIdentifier) as! FooterCell
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section] {
        case provinceDataIdentifier:
            stickyHeaderView  = ProvinceTabView(frame: .zero)
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

extension MainViewController: MainViewDelegate {
    func changeProvinceData(type: PatientType, index: Int) {
        selectedPatientType = type
        selectedSegmentIndex = index
        if let section = sections.firstIndex(of: provinceDataIdentifier) {
            tableView.reloadSections([section], with: .automatic)
        }
    }
}
