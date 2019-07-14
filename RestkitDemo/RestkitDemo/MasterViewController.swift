//
//  MasterViewController.swift
//  RestkitDemo
//
//  Created by Kirti Parghi on 7/13/19.
//  Copyright © 2019 Kirti Parghi. All rights reserved.
//

import UIKit
import RestKit

class Constants {
    // MARK: List of Constants
    static let CLIENTID = "SSFGCP1ZNIZ4BXDLMNEY1OWMHHNLJIWZRMQ5ZOAVCI14ZDTK"
    static let CLIENTSECRET = "1TIID5QUOSDHW0PKI0V2M2ZSPMWQJ40IEQMGQC0JU3I5NDD2"
}

class MasterViewController: UITableViewController {

    var _venues = [Venue]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureRestKit()
        self.loadVenues()
    }

    func configureRestKit() {
        // initialize AFNetworking HTTPClient
        let baseURL  = NSURL(string: "https://api.foursquare.com")
        let objectManager = RKObjectManager(httpClient: AFRKHTTPClient(baseURL: baseURL as URL?))
        
        let venueMapping = RKObjectMapping(for: Venue.self)
        venueMapping?.addAttributeMappings(from: ["name"])
        
        let locationMapping = RKObjectMapping(for: Location.self)
        locationMapping?.addAttributeMappings(from: ["address","city","country","crossStreet","postalCode","state","distance","lat","lng"])
        
        let statsMapping = RKObjectMapping(for: Stats.self)
        statsMapping?.addAttributeMappings(from: ["checkinsCount":"checkins","tipsCount":"tips","usersCount":"users"])
        
        venueMapping?.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "location", toKeyPath: "location", with: locationMapping))
        
        venueMapping?.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "stats", toKeyPath: "stats", with: statsMapping))
        
        let responseDescriptor = RKResponseDescriptor(mapping: venueMapping, method: .GET, pathPattern: "/v2/venues/search", keyPath: "response.venues", statusCodes: IndexSet(integer: 200))
        
        objectManager?.addResponseDescriptor(responseDescriptor)
    }
    
    func loadVenues() {
        let latLon = "37.33,-122.03"
        let queryParams = ["categoryId":"4bf58dd8d48988d1e0931735", "client_id":Constants.CLIENTID, "client_secret":Constants.CLIENTSECRET, "ll":latLon, "v":"20140118"]
        
        RKObjectManager.shared()?.getObjectsAtPath("/v2/venues/search", parameters: queryParams, success: { (opeation, mappingResult) in
            self._venues = (mappingResult?.array())! as! [Venue]
            print(self._venues.count)
            self.tableView.reloadData()
        }, failure: { (operation, error) in
            print("What do you mean by there is no coffee \(String(describing: error))")
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _venues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell") as! VenueCell
        let object = _venues[indexPath.row]
        cell.nameLabel.text = object.name
        cell.distanceLabel.text = String(format: "%.0fm", arguments: [object.location.distance.floatValue])
        cell.checkinsLabel.text = String(format: "%d checkins", arguments: [object.stats.checkins.intValue])
        return cell
    }
}

