//
//  SchoolCell.swift
//  20230512-VibhorSingla-NYCSchools
//
//  Created by Vibhor Singla on 12/05/23.
//

import Foundation
import UIKit

class SchoolCell: UITableViewCell {

    @IBOutlet weak var imgSchool: UIImageView!
    @IBOutlet weak var lblSchoolName: UILabel!
    @IBOutlet weak var lblSchoolLocation: UILabel!
    
    var schoolDetails : SchoolListModel? {
        didSet {
            if let details = schoolDetails {
                self.lblSchoolName.text = details.school_name ?? "NA"
                self.lblSchoolLocation.text = details.location ?? "NA"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
