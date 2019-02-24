//
//  UserConfigurationViewController.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 2/22/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation
import UIKit

var player = Player()

class UserConfigurationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    // UI OUTLETS
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var skillPointsLabel: UILabel!
    @IBOutlet var pilotPointsLabel: UILabel!
    @IBOutlet var pilotStepper: UIStepper!
    @IBOutlet var fighterPointsLabel: UILabel!
    @IBOutlet var fighterStepper: UIStepper!
    @IBOutlet var traderPointsLabel: UILabel!
    @IBOutlet var traderStepper: UIStepper!
    @IBOutlet var engineerPointsLabel: UILabel!
    @IBOutlet var engineerStepper: UIStepper!
    @IBOutlet var difficultyPicker: UIPickerView!
    
    var difficultyData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.difficultyPicker.delegate = self
        self.difficultyPicker.dataSource = self
        
        difficultyData = ["Beginner", "Easy", "Normal", "Hard", "Impossible"]
    }
    
    
    @IBAction func pilotStepperChanged(_ sender: UIStepper) {
        guard player.getAvailableSkillPoints() > 0 else { return }
        pilotPointsLabel.text = String(Int(sender.value))
        player.setPilotPoints(newPoints: Int(sender.value))
        player.setAvailableSkillPoints(newPoints: calculateAvailablePoints())
        skillPointsLabel.text = String(player.getAvailableSkillPoints())
    }
    
    @IBAction func fighterStepperChanged(_ sender: UIStepper) {
        guard player.getAvailableSkillPoints() > 0 else { return }
        fighterPointsLabel.text = String(Int(sender.value))
        player.setFighterPoints(newPoints: Int(sender.value))
        player.setAvailableSkillPoints(newPoints: calculateAvailablePoints())
        skillPointsLabel.text = String(player.getAvailableSkillPoints())
    }
    
    @IBAction func traderStepperChanged(_ sender: UIStepper) {
        guard player.getAvailableSkillPoints() > 0 else { return }
        traderPointsLabel.text = String(Int(sender.value))
        player.setTraderPoints(newPoints: Int(sender.value))
        player.setAvailableSkillPoints(newPoints: calculateAvailablePoints())
        skillPointsLabel.text = String(player.getAvailableSkillPoints())
    }
    
    @IBAction func engineerStepperChanged(_ sender: UIStepper) {
        guard player.getAvailableSkillPoints() > 0 else { return }
        engineerPointsLabel.text = String(Int(sender.value))
        player.setEngineerPoints(newPoints: Int(sender.value))
        player.setAvailableSkillPoints(newPoints: calculateAvailablePoints())
        skillPointsLabel.text = String(player.getAvailableSkillPoints())
        
    }
    
    private func calculateAvailablePoints() -> Int {
        return 16 - (player.getPilotPoints() + player.getTraderPoints()
                + player.getFighterPoints() + player.getEngineerPoints())
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return difficultyData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = difficultyData[row]
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    @IBAction func createUserPressed(_ sender: Any) {
        guard let username = usernameTextField.text else { return }
        guard player.getAvailableSkillPoints() == 0 else { return }
        guard isValidUsername(username: username) else { return }
        player.setName(newName: username)
        self.performSegue(withIdentifier: "togamescreen", sender: nil)
    }
    
    private func isValidUsername(username: String) -> Bool {
        guard username != "" else { return false }
        guard username != "Name" else { return false }
        guard username != "player" else { return false }
        return true
    }
}
