//
//  InfoView.swift
//  WaadsuTask
//
//  Created by Danil Kovalev on 11.07.2022.
//

import UIKit

class InfoView: UIView, NibLoadable {
    
    @IBOutlet private weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(by text: String) {
        valueLabel.text = text
    }
}
