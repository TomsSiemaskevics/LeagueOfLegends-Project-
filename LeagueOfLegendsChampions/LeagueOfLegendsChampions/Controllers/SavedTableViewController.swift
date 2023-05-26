//
//  SavedTableViewController.swift
//  LeagueOfLegendsChampions
//
//  Created by toms.siemaskevics on 23/05/2023.
//

import UIKit
import CoreData
import SDWebImage

class SavedTableViewController: UITableViewController {
    

    
    @IBOutlet var savedChampionTable: UITableView!
    var savedItems = [Items]()
    var context: NSManagedObjectContext?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        loadCoreData()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCoreData()
        
            }
    
    func countItems() {
        let itemsInTable = String(self.tableView.numberOfRows(inSection: 0))
        
        self.title = "\(itemsInTable) Saved Items"
    }
    
    func loadCoreData() {
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        
        do {
            savedItems = try (context?.fetch(request))!
            tableView.reloadData()
        } catch {
            
            print(error)
        }
        tableView.reloadData()
        countItems()

    }
    
    func saveCoreData(){
        do {
            try context?.save()
            basicAlert(title: "Removed!", message: "Item Deleted")
            
        } catch {
            
            print(error)
            
        }
        
        loadCoreData()
    }
    func deleteAllCoreData(){
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
            
            let entityRequest: NSBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context?.execute(entityRequest)
                saveCoreData()
            }catch let error{
                print(error.localizedDescription)
                fatalError("Error in saving item in to Items")
            }
        }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    // MARK: - Table view data source

 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if savedItems.count == 0 {
            tableView.setEmptyView(title: "No Data", message: "Check Champions List!")
        }
        
        else {
            
            tableView.restore()
            
        }
        
        return savedItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as? SavedTableViewCell else { return UITableViewCell() }
        
        let item = savedItems[indexPath.row]
        
        cell.savedChampionIdLabel?.text = "ID: " + String(item.champId)
        cell.savedChampionNameLabel.text = item.champName
        cell.savedChampionTitleLabel.text = item.champTitle
        cell.savedChampionImageView.image = convertBase64StringToImage(imageBase64String: item.champView!)
        
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }



    
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                    let item = self.savedItems[indexPath.row]
                    self.context?.delete(item)
                    self.saveCoreData()
                    tableView.reloadData()
                }))
                self.present(alert, animated: true)
            }
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
       
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
       
        
        
        let item = savedItems[indexPath.row]
        
        vc.championIdInt = Int(item.champId)
        vc.nameString = item.champName!
        vc.titleString = item.champTitle!
        
        vc.difficulltyInt = Int(item.champDifficulty)
        vc.damageInt = Int(item.champDamage)
        vc.abillityPowerInt = Int(item.champAbilityPower)
        vc.armorInt = Int(item.champArmor)
        vc.magicResistInt = Int(item.champMagicResist)
        
        vc.hasteInt = Int(item.champHaste)
        vc.hpRegenDouble = item.champHpRegen
        vc.attackRangeInt = Int(item.champAttackRange)
        vc.movementSpeedInt = Int(item.champMovementSpeed)
        vc.selectedImage = convertBase64StringToImage(imageBase64String: item.champView!)
        
       
        navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func deleteAllDataTapped(_ sender: Any) {
     
            deleteAllCoreData()
            // Update the table view
            
            tableView.reloadData()
        
        let alert = UIAlertController(title: "Items Removed", message: "All items have been removed!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        
    }
    
}

extension UITableView {
    
    func setEmptyView(title: String, message: String) {
        
        self.backgroundView = UIImageView(image: UIImage(named: "EmptyView"))
        self.separatorStyle = .none
    }
    
    func restore() {
        
        self.backgroundView = nil
        self.separatorStyle = .singleLine
        
    }
}
