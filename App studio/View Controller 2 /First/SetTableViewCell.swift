//
//  TableViewSetTableViewCell.swift
//  Il mio prototipo
//
//  Created by Vito Guglielmino on 16/12/2021.
//

import UIKit

class SetTableViewCell: UITableViewCell {

    @IBOutlet weak var programView: UIView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var pageDoneLabel: UILabel!
    @IBOutlet weak var pageToDoLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // celle dei programmi di studio stondate 
        self.programView.layer.cornerRadius = 10
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
