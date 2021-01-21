//
//  DefinitionViewController.swift
//  Emoji Dictionary
//
//  Created by Bryan Nelson on 1/12/21.
//

import UIKit

class DefinitionViewController: UIViewController {

    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    
    var emoji = Emoji()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emojiLabel.text = emoji.character
        definitionLabel.text = "The \(emoji.character) is a \(emoji.definition). It was made in \(emoji.year), is in the \(emoji.category) and Bryan gave it a \(emoji.rating)."
    }
    
}
