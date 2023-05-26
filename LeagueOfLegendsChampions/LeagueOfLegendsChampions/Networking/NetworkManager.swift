//
//  NetworkManager.swift
//  LeagueOfLegendsChampions
//
//  Created by toms.siemaskevics on 23/05/2023.
//

import Foundation

class NetworkManager {
    
    static let api = "https://api.sportsdata.io/v3/lol/stats/json/Champions?key=aee190946d47480e954ca461b0597512"
    static func fetchData(url: String, completion: @escaping ([ChampionItem]) -> () ) {

        guard let url = URL(string: url) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true

        URLSession(configuration: config).dataTask(with: request) { (data, response, err ) in

            guard err == nil else {
                print("err:::::", err!)
                return
            }

            //print("response:", response as Any)

            guard let data = data else { return }


            do {
                let jsonData = try JSONDecoder().decode([ChampionItem].self, from: data)
                completion(jsonData)
            }catch{
                print("err:::::", error)
            }

        }.resume()

    }
    
    
}
