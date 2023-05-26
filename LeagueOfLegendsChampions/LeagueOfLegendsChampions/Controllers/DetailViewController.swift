//
//  DetailViewController.swift
//  LeagueOfLegendsChampions
//
//  Created by toms.siemaskevics on 23/05/2023.
//

import UIKit
import CoreData
import SDWebImage

class DetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var championsTitleLabel: UILabel!
    
    @IBOutlet weak var championDifficultyLabel: UILabel!
    
    @IBOutlet weak var championsImageView: UIImageView!
    
    @IBOutlet weak var championsAttackDamageLabel: UILabel!
    
    @IBOutlet weak var championsAbilityPowerLabel: UILabel!
    
    @IBOutlet weak var championsArmorLabel: UILabel!
    
    @IBOutlet weak var championsMagicResistLabel: UILabel!
    
    @IBOutlet weak var championsHasteLable: UILabel!
    
    @IBOutlet weak var championsHpRegenLable: UILabel!
    
    
    @IBOutlet weak var championsAttackRangeLabel: UILabel!
    
    @IBOutlet weak var championsMovementSpeedLabel: UILabel!
    
    
    var selectedImage: UIImage?
    var champIdInt: Int = Int()
    var nameString: String = String()
    var difficulltyInt: Int = Int()
    var titleString: String = String()
    var damageInt: Int = Int()
    var abillityPowerInt: Int = Int()
    var armorInt: Int = Int()
    var magicResistInt: Int = Int()
    var hasteInt: Int = Int()
    var hpRegenDouble: Double = Double()
    var attackRangeInt: Int = Int()
    var movementSpeedInt: Int = Int()
    
    
    var championIdInt: Int = Int()
    
    var savedItems = [Items]()
    var context: NSManagedObjectContext?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = nameString
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        updateDetails()
            }
    func updateDetails() {
        championsImageView.image = selectedImage
        championsTitleLabel.text = titleString
        championDifficultyLabel.text = "Difficulty:" + String(difficulltyInt)
        championsAttackDamageLabel.text = String(damageInt)
        championsAbilityPowerLabel.text = String(abillityPowerInt)
        championsArmorLabel.text = String(armorInt)
        championsMagicResistLabel.text = String(magicResistInt)
        
        championsHasteLable.text = String(hasteInt)
        championsHpRegenLable.text = String(hpRegenDouble)
        championsAttackRangeLabel.text = String(attackRangeInt)
        championsMovementSpeedLabel.text = String(movementSpeedInt)
        
        // Create a UIImageView with the desired background image
                let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "EmptyView")
                
                // Adjust the content mode of the image view to fit the image
                backgroundImage.contentMode = .scaleAspectFill
                
                // Add the image view as a subview of the view controller's main view
                view.addSubview(backgroundImage)
                view.sendSubviewToBack(backgroundImage)
                                         
    }
    func saveData() {
        do {
            try context?.save()
            basicAlert(title: "Saved", message: "\(nameString) has been saved in Save List")
        }catch {
            print(error)
        }
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let champItem = Items(context: self.context!)
        
        
        
        champItem.champId = Int32(championIdInt)
        
        champItem.champName = nameString
        champItem.champTitle = titleString
        champItem.champDifficulty = Int32(difficulltyInt)
       
        champItem.champDamage = Int32(damageInt)
        champItem.champAbilityPower = Int32(abillityPowerInt)
        champItem.champArmor = Int32(armorInt)
        champItem.champMagicResist = Int32(magicResistInt)
        
        champItem.champHaste = Int32(hasteInt)
        champItem.champHpRegen = Double(hpRegenDouble)
        champItem.champAttackRange = Int32(attackRangeInt)
        champItem.champMovementSpeed = Int32(movementSpeedInt)
        champItem.champView = convertImageToBase64String(img: selectedImage!)

        self.savedItems.append(champItem)
        saveData()
    }
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
        
       
    }
    





