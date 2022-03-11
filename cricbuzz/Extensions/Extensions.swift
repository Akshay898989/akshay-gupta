//
//  Extensions.swift
//  cricbuzz
//
//  Created by Akshay on 11/03/22.
//

import Foundation
import UIKit
extension UIImageView {
    
  public func imageFromServerUsingUrl(url: String) {
    let urlString = url
    URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: {[weak self] (data, response, error) -> Void in
        guard let self=self else{return}
        guard let data=data else{
            DispatchQueue.main.async {
                self.image = UIImage(named: "error")
            }
            return
            
        }
      if error != nil {
        DispatchQueue.main.async {
            self.image = UIImage(named: "error")
        }
        return
      }
      DispatchQueue.main.async { () -> Void in
        if let image = UIImage(data: data){
            self.image = image
        }else{
            self.image = UIImage(named: "error")
        }
        
      }
    }).resume()
  }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
