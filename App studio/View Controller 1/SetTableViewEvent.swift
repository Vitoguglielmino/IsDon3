//
//  SetTableViewEvent.swift
//  Il mio prototipo
//
//  Created by Vito Guglielmino on 23/12/2021.
//

import UIKit
//import FSCalendar

class SetTableViewEvent : UITableViewCell {
    
    @IBOutlet weak var eventView: UIView!
    
    @IBOutlet weak var subject: UILabel!
    
    @IBOutlet weak var pageDay: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // celle dei programmi di studio stondate
        self.eventView.layer.cornerRadius = 10
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}




