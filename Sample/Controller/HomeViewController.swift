//
//  HomeViewController.swift
//  Sample
//
//  Created by Samarth Paboowal on 31/01/18.
//  Copyright © 2018 Samarth Paboowal. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import ObjectMapper

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Variables
    
    var collections = APIResponse()
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = LoggedUser.username()!
        
        fetchData()
    }
    
    func fetchData() {
        
        let header = ["Authorization": "Bearer FlochatIosTestApi"]
        
        Alamofire.request("http://35.154.75.20:9090/test/ios", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if let value = response.value as? NSDictionary {
                
                self.collections = Mapper<APIResponse>().map(JSON: value as! [String : Any])!
                self.setupViews()
            } else {
                print("Unable to fetch data")
            }
        }
    }
    
    func setupViews() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.tableView.reloadData()
    }
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        
        LoggedUser.clearUserData()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "loginVC")
        let navigation = UINavigationController(rootViewController: viewController)
        UIApplication.shared.keyWindow?.rootViewController = navigation
    }
    
    
    //MARK: - Segue Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is WebViewController {
            let vc = segue.destination as? WebViewController
            vc?.data = sender as! FoodCollection
        }
    }
    
    
    //MARK: - Table View Delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (collections.collections?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = collections.collections![indexPath.row].collection!
        performSegue(withIdentifier: "push", sender: data)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodTableViewCell
        cell.data = collections.collections![indexPath.row].collection!
        cell.setupViews()
        cell.selectionStyle = .none
        
        return cell
    }
}
