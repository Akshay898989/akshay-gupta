//
//  MoviesTableViewController.swift
//  cricbuzz
//
//  Created by Akshay on 10/03/22.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    // MARK: Vars
    var data:[String] = ["Year","Genres","Directors","Actors"]
    var filteredMovies:[Movies] = []
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel = MoviesViewModel()
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        tableView.tableFooterView = UIView()
        viewModel.decodeData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? filteredMovies.count : data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !searchController.isActive{
            let cell = tableView.dequeueReusableCell(withIdentifier: "movies", for: indexPath) as! MoviesTableViewCell
            cell.titleLabel.text = data[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "moviesList", for: indexPath) as! MovieListTableViewCell
            cell.posterImage.imageFromServerUsingUrl(url: filteredMovies[indexPath.row].poster)
                cell.movieTitleLabel.text = filteredMovies[indexPath.row].title
            cell.languageLabel.text = filteredMovies[indexPath.row].language
            cell.yearLabel.text = filteredMovies[indexPath.row].year

            return cell
        }
       
    }
    // MARK: TableView Delegates
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if searchController.isActive{
            showMoviesDetailView(indexPath.row)
        }else{
            showOptionsView(indexPath.row)
        }
        
    }

    // MARK: Navigation
    private func showOptionsView(_ row:Int){
        let optionsView = UIStoryboard(name:"OptionListStoryboard",bundle:nil).instantiateViewController(identifier: "optionList") as! OptionListTableViewController
        
        optionsView.behaveAs = viewModel.getOptionType(row)
        optionsView.data = viewModel.moviesData
        self.navigationController?.pushViewController(optionsView, animated: true)
    }
    // MARK: Navigation
    private func showMoviesDetailView(_ row:Int){
        let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! MovieListTableViewCell
        
        let moviesdata = MovieDetail(poster: cell.posterImage.image, movieName: viewModel.moviesData[row].title, duration_year: viewModel.moviesData[row].runtime + " | " + viewModel.moviesData[row].year, rating: viewModel.moviesData[row].ratings,plot: viewModel.moviesData[row].plot)
        let moviesDetailView = UIStoryboard(name:"MovieDetailStoryboard",bundle:nil).instantiateViewController(identifier: "movieDetail") as! MovieDetailViewController
        moviesDetailView.movieDetailData = moviesdata
        self.navigationController?.pushViewController(moviesDetailView, animated: true)
    }
    // MARK: Seatup search controller
    
    private func setupSearchController(){
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies by title/actor/genre/director"
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
    }
    
    private func filterdContentForSearchText(searchText: String){
        filteredMovies = viewModel.moviesData.filter{
            $0.year.lowercased().contains(searchText.lowercased()) ||
            $0.genre.lowercased().contains(searchText.lowercased()) ||
                $0.director.lowercased().contains(searchText.lowercased()) ||
                $0.actors.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
        
    }
    
}

extension MoviesTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterdContentForSearchText(searchText: searchController.searchBar.text!)
    }

}
