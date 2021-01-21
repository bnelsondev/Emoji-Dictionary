//
//  EmojiTableViewController.swift
//  Emoji Dictionary
//
//  Created by Bryan Nelson on 1/12/21.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    let emojis = getEmojis()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    // How many rows?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }
    
    // What goes in each row?
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        cell.textLabel?.text = "\(emojis[indexPath.row].character) - \(emojis[indexPath.row].definition)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedEmoji = emojis[indexPath.row]
        
        performSegue(withIdentifier: "definitionSegue", sender: selectedEmoji)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let definitionVC = segue.destination as? DefinitionViewController {
            if let selectedEmoji = sender as? Emoji {
                definitionVC.emoji = selectedEmoji
            }
        }
    }

}
