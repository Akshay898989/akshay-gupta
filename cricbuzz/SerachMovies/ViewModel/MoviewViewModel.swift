//
//  MoviewViewModel.swift
//  cricbuzz
//
//  Created by Akshay on 10/03/22.
//

import Foundation

class MoviesViewModel{
    
    var moviesData:[Movies] = []
    
    func decodeData(){
        do {
            if let bundlePath = Bundle.main.path(forResource: "movies",
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                self.moviesData = try JSONDecoder().decode([Movies].self, from: jsonData)
            }
        } catch {
            print(error)
        }
    }
    func getOptionType(_ row:Int)->OptionBehaveAs{
        switch row {
        case 0:
            return .year
        case 1:
            return .genres
        case 2:
            return .directors
        case 3:
            return .actors
        default:
            return .year
        }
    }
}
