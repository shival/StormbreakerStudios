//
//  Webservice.swift
//
//
//  Created by Shival Pandya on 2020-01-19.
//  Copyright © 2020 Shival Pandya. All rights reserved.
//

import UIKit
import PKHUD
import Reachability

struct Api {
    static let baseUrl = "https://api.500px.com/v1/"
    static let photo = baseUrl + "photos?"
    static let consumer_key = "P7LLhKkPAnPUpbfAXk3Jq2iDjYmCx87zgfEDxQVS"
}

enum HTTPMethod: String {
    case GET = "GET"
}

class Webservice {
    
    public class func showHud() {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
    }
    
    public class func hideHud() {
        PKHUD.sharedHUD.hide(true)
    }
    
    class func genericRequest<T: Decodable>(parameters: Any?, urlString: String, httpMethod: String, showHud:Bool = true, completionHandler: @escaping (T?, String?) -> ()) {
        
        do {
            
            let reachability = try Reachability()
            
            if reachability.connection != .unavailable {
                
                if showHud {
                    Webservice.showHud()
                }
                
                guard let url = URL(string: urlString) else {
                    if showHud {
                        Webservice.hideHud()
                    }
                    //print("Incorrect URL.")
                    return
                }
                
                print(url)
                let request = URLRequest(url: url)
                
                let sessionConfiguration = URLSessionConfiguration.default
                let session = URLSession(configuration: sessionConfiguration)
                
                session.dataTask(with: request) { (data, response, error) in
                    guard error == nil else {
                        DispatchQueue.main.async {
                            if showHud {
                                Webservice.hideHud()
                            }
                            completionHandler(nil, error?.localizedDescription)
                        }
                        return
                    }
                    
                    guard let responseData = data else {
                        DispatchQueue.main.async {
                            if showHud {
                                Webservice.hideHud()
                            }
                            completionHandler(nil, "Error: did not receive data")
                        }
                        return
                    }
                    
                    do {
                        print("Data - \n \(String(data: responseData, encoding: .utf8) ?? "")")
                        let modelObject = try JSONDecoder().decode(T.self, from: responseData)
                        DispatchQueue.main.async {
                            if showHud {
                                Webservice.hideHud()
                            }
                            completionHandler(modelObject, nil)
                        }
                    } catch let err {
                        DispatchQueue.main.async {
                            if showHud {
                                Webservice.hideHud()
                            }
                            completionHandler(nil, "\(err.localizedDescription)")
                        }
                        return
                    }
                    
                    }.resume()
            } else {
                completionHandler(nil, "You are not connected to the internet.")
            }
        } catch {
             completionHandler(nil, "You are not connected to the internet.")
        }
    }
}
