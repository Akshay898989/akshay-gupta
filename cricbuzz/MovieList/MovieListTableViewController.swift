//
//  MovieListTableViewController.swift
//  cricbuzz
//
//  Created by Akshay on 10/03/22.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    // MARK: Vars
    var moviesListData:[Movies] = [Movies]()
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moviesListData.count
        //return searchController.isActive ? filteredUsers.count : data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesList", for: indexPath) as! MovieListTableViewCell
        cell.posterImage.imageFromServerUsingUrl(url: moviesListData[indexPath.row].poster)
        cell.movieTitleLabel.text = moviesListData[indexPath.row].title
        cell.yearLabel.text = moviesListData[indexPath.row].year
        cell.languageLabel.text = moviesListData[indexPath.row].language

        return cell
    }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showMoviesDetailView(indexPath.row)
    }
    // MARK: Navigation
    private func showMoviesDetailView(_ row:Int){
        let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! MovieListTableViewCell
        
        let moviesdata = MovieDetail(poster: cell.posterImage.image, movieName: moviesListData[row].title, duration_year: moviesListData[row].runtime + " | " + moviesListData[row].year, rating: moviesListData[row].ratings,plot: moviesListData[row].plot)
        let moviesDetailView = UIStoryboard(name:"MovieDetailStoryboard",bundle:nil).instantiateViewController(identifier: "movieDetail") as! MovieDetailViewController
        moviesDetailView.movieDetailData = moviesdata
        self.navigationController?.pushViewController(moviesDetailView, animated: true)
    }

}
