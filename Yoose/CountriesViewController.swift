//
//  CountriesViewController.swift
//  Yoose
//
//  Created by Indigo´sDad on 2020-03-08.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import UIKit
import ViewAnimator

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    let country = Countries()
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    var filteredCountries:[String] = []
    var isSearching: Bool{
        if filteredCountries.count > 0{
        return true
    }
    return false
    
    }

    override func viewDidLoad() {
           super.viewDidLoad()
        zoomtransition()
        navigationItem.searchController = searchController
              
              
              tableView.delegate = self
              tableView.dataSource = self
           // Do any additional setup after loading the view.
        
            searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
            //searchController.searchResultsUpdater = self
            navigationItem.searchController = searchController
       }
    override func viewDidAppear(_ animated: Bool) {
        zoomtransition()
    }
    func zoomtransition(){
        let animation = AnimationType.zoom(scale: 0.5)
        view.animate(animations: [animation])
    }
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
           
            return filteredCountries.count
                   }
        return country.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountriesTableViewCell
        
        if isSearching{
            cell.textLabel?.text = filteredCountries[indexPath.row]
        }
        else{
            cell.textLabel?.text = country.countries[indexPath.row]
        }
        return cell
    }
    

}
extension CountriesViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
          
            print("SearchText: \(searchController.searchBar.text ?? "")")
            
            if let searchText = searchController.searchBar.text?.lowercased(){
                
                filteredCountries = country.countries.filter({$0.lowercased().contains(searchText.lowercased())})
                
                   
            }
            else{
                filteredCountries = []
            }
            // self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
            tableView.reloadData()
        }
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


