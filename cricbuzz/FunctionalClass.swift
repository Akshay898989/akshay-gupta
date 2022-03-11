//
//  FunctionalClass.swift
//  cricbuzz
//
//  Created by Akshay on 10/03/22.
//

import Foundation
import UIKit
class Function{
    
  }

extension UIImageView {
  public func imageFromServerUsingUrl(url: String) {
    let urlString = url
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    self.layoutIfNeeded()
    activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    self.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
        guard let data=data else{return}
      if error != nil {
        //print("error setting image===",error)
        DispatchQueue.main.async {
            self.image = UIImage(named: "warning")
            activityIndicator.removeFromSuperview()
        }
        
        return
      }
      DispatchQueue.main.async { () -> Void in
        let image = UIImage(data: data)
        self.image = image
        activityIndicator.removeFromSuperview()
      }
    }).resume()
  }
}
