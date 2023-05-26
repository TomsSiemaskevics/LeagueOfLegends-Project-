// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let championItem = try? JSONDecoder().decode(ChampionItem.self, from: jsonData)

import Foundation

// MARK: - ChampionItem
struct ChampionItem: Codable {
    let attack, defense, magic, difficulty: Int
    let hp, hpUpPerLevel: Int?
    let mp, mpUpPerLevel: Double?
    let moveSpeed, armor: Int
    let armorPerLevel: Double?
    let spellBlock: Int
    let spellBlockPerLevel: Double?
    let attackRange: Int
    let hpRegen, hpRegenPerLevel, mpRegen, mpRegenPerLevel: Double
    let attackDamage: Int
    let attackDamagePerLevel: Double?
    let attackSpeedOffset: Int
    let championID: Int
    let name: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case attack = "Attack"
        case defense = "Defense"
        case magic = "Magic"
        case difficulty = "Difficulty"
        case hp = "Hp"
        case hpUpPerLevel = "HpUpPerLevel"
        case mp = "Mp"
        case mpUpPerLevel = "MpUpPerLevel"
        case moveSpeed = "MoveSpeed"
        case armor = "Armor"
        case armorPerLevel = "ArmorPerLevel"
        case spellBlock = "SpellBlock"
        case spellBlockPerLevel = "SpellBlockPerLevel"
        case attackRange = "AttackRange"
        case hpRegen = "HpRegen"
        case hpRegenPerLevel = "HpRegenPerLevel"
        case mpRegen = "MpRegen"
        case mpRegenPerLevel = "MpRegenPerLevel"
        case attackDamage = "AttackDamage"
        case attackDamagePerLevel = "AttackDamagePerLevel"
        case attackSpeedOffset = "AttackSpeedOffset"
        case championID = "ChampionId"
        case name = "Name"
        case title = "Title"
    }
}


