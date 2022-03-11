//
//  OptionListTableViewController.swift
//  cricbuzz
//
//  Created by Akshay on 10/03/22.
//

import UIKit

class OptionListTableViewController: UITableViewController {
    // MARK: Vars
    var data:[Movies] = [Movies]()
    var behaveAs:OptionBehaveAs = .year
    var tableData:[String] = []
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData = getData()
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = behaveAs.rawValue
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movies", for: indexPath) as! MoviesTableViewCell
        cell.titleLabel.text =  tableData[indexPath.row]

        return cell
    }
    // MARK: TablrView Delegates
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        //headerView.backgroundColor = UIColor(named: "")
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showMoviesView(indexPath.row)
    }
    
    // MARK: Navigation
    private func showMoviesView(_ row:Int){
        var moviesdata = [Movies]()
        switch behaveAs {
        case .year:
            moviesdata = data.filter{$0.year==tableData[row]}
        case .genres:
            moviesdata = data.filter{$0.genre==tableData[row]}
        case .directors:
            moviesdata = data.filter{$0.director==tableData[row]}
        case .actors:
            moviesdata = data.filter{$0.actors==tableData[row]}
        }
        let optionsView = UIStoryboard(name:"MovieListStoryboard",bundle:nil).instantiateViewController(identifier: "movieList") as! MovieListTableViewController
        optionsView.moviesListData = moviesdata
        self.navigationController?.pushViewController(optionsView, animated: true)
    }
    private func getData()->[String]{

        switch behaveAs {
        case .year:
            return (data.compactMap{$0.year}.uniqued().sorted())
        case .genres:
        return (data.compactMap{$0.genre}.uniqued().sorted())
        case.directors:
        return (data.compactMap{$0.director}.uniqued().sorted())
        case.actors:
        return (data.compactMap{$0.actors}.uniqued().sorted())
        }
    }
    
    
}

enum OptionBehaveAs:String{
    case year = "Year"
    case genres = "Genres"
    case directors = "Directors"
    case actors = "Actors"
}
