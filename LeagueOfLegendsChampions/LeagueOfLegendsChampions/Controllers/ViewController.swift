//
//  ViewController.swift
//  LeagueOfLegendsChampions
//
//  Created by toms.siemaskevics on 23/05/2023.
//

import UIKit

class ViewController: UIViewController {
    private var champions: [ChampionItem] = []

    
    @IBOutlet weak var championsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "League Of Legends"
        
        fetchDataFromAPI()
        championsTableView.backgroundView = UIImageView(image: UIImage(named: "EmptyView"))
        championsTableView.reloadData()
        
       
    }
    
    func getRandomImage() -> UIImage? {
            let imageNames = ["Image1", "Image2", "Image3"]
            
            if let randomImageName = imageNames.randomElement() {
                return UIImage(named: randomImageName)
            }
            
            return nil
        }
    func fetchDataFromAPI() {
            let urlString = "https://api.sportsdata.io/v3/lol/stats/json/Champions?key=aee190946d47480e954ca461b0597512"
            
            if let url = URL(string: urlString) {
                let session = URLSession.shared
                let task = session.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        print("Invalid response")
                        return
                    }
                    
                    guard let responseData = data else {
                        print("No data received")
                        return
                    }
                    
                    do {
                        self.champions = try JSONDecoder().decode([ChampionItem].self, from: responseData)
                        DispatchQueue.main.async {
                            self.championsTableView.reloadData()
                        }
                    } catch {
                        print("Error while parsing JSON: \(error.localizedDescription)")
                    }
                }
                
                task.resume()
            }
        }
        }
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return champions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "championsCell", for: indexPath) as? ChampionTableViewCell else { return UITableViewCell() }
        
        let item = champions[indexPath.row]
        cell.championsIdLabel.text = "ID : \(item.championID)"
        cell.championsNameLabel.text = item.name
        cell.championsTitleLabel.text = item.title
        
        cell.championsImageView?.image = getRandomImage()
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        championsTableView.deselectRow(at: indexPath, animated: true)
        
       
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        
        let item = champions[indexPath.row]
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! ChampionTableViewCell
        let selectedImage = selectedCell.championsImageView.image
        
        vc.selectedImage = selectedImage
        vc.championIdInt = item.championID
        vc.nameString = item.name
        vc.titleString = item.title
        
        vc.difficulltyInt = item.difficulty
        vc.damageInt = item.attack
        vc.abillityPowerInt = item.magic
        vc.armorInt = item.armor
        vc.magicResistInt = item.spellBlock
        
        vc.hasteInt = item.attackSpeedOffset
        vc.hpRegenDouble = item.hpRegen
        vc.attackRangeInt = item.attackRange
        vc.movementSpeedInt = item.moveSpeed
        
       
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

