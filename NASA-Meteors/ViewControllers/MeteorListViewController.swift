//
//  MeteorListViewController.swift
//  NASA-Meteors
//
//  Created by Daniel Farrell on 02/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import UIKit
import MapKit

class MeteorListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    private let refreshControl = UIRefreshControl()
    var meteorsFromAPI = [Meteor]()
    @IBOutlet var meteorTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        meteorNetworkCall()
        setupRefreshContorl()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(meteorsFromAPI.count)
        return meteorsFromAPI.count
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = meteorTableView.dequeueReusableCell(withIdentifier: "meteorCell") as! MeteorCell
        cell.meteorNameLabel.text = meteorsFromAPI[indexPath.row].name
        cell.meteorMassLabel.text = meteorsFromAPI[indexPath.row].mass
        let date = meteorsFromAPI[indexPath.row].year?.description
        let formattedDate = String(date?.prefix(4) ?? "")
        cell.meteorDateLabel.text = formattedDate
        
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mapPopupSegue") {
            let mapPopup = segue.destination as? MeteorSelectionMapPopup
            if let indexPath = self.meteorTableView.indexPathForSelectedRow {
                let selectedName = self.meteorsFromAPI[indexPath.row].name
                let selectedLat = self.meteorsFromAPI[indexPath.row].latitude
                let selectedLong = self.meteorsFromAPI[indexPath.row].longitude
                mapPopup!.selectedMeteorName = selectedName
                mapPopup!.selectedMeteorLat = selectedLat!
                mapPopup!.selectedMeteorLong = selectedLong!
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "mapPopupSegue", sender: self)
    }
    
    
    func setupRefreshContorl() {
        meteorTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshMeteorData(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Meteor Data...")
    }
    
    /*
     * Make call to NASA API and populate table view with
     * meteors that fell after 1900
     */
    func meteorNetworkCall() {
        let service = MeteorNetworking()
        service.retrieveMeteorsFromAPI() { meteors in
            for meteor in meteors {
                let formatter = StartDateFormatter()
                let startDate = formatter.formatDate()
                if (meteor.year ?? startDate > startDate) {
                    self.meteorsFromAPI.append(meteor)
                }
            }
            DispatchQueue.main.async{
                self.meteorTableView.reloadData()
            }
        }
    }
    
    @objc private func refreshMeteorData(_ sender: Any) {
        meteorNetworkCall()
        self.refreshControl.endRefreshing()
    }
    
    
}
