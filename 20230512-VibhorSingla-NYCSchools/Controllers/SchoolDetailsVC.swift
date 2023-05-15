//
//  SchoolDetailsVC.swift
//  20230512-VibhorSingla-NYCSchools
//
//  Created by Vibhor Singla on 12/05/23.
//

import Foundation
import UIKit

class SchoolDetailsVC: UIViewController {

    @IBOutlet weak var lblSchoolName: UILabel!
    @IBOutlet weak var lblOverviewPara: UILabel!
    @IBOutlet weak var lblNumOfTestTakers: UILabel!
    @IBOutlet weak var lblSatReadingScore: UILabel!
    @IBOutlet weak var lblSatMathScore: UILabel!
    @IBOutlet weak var lblSatWritingScore: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    
    var dbn : String?
    private var schoolSATVm = SchoolSATVM()
    var schoolDetail: SchoolListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schoolSATVm.schoolSATVmDelegate = self
        schoolSATVm.dbnNum = dbn
        schoolSATVm.getSchoolSatDetails()
    }

    @IBAction func btnBackTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SchoolDetailsVC: SchoolSATVMDelegate {
    func didReceiveSchoolSATResponse(schoolSATResponse: SchoolSATModel?, err: NetworkError?) {
        if err != nil, let error = err {
            Alert(message: error.localizedDescription)
        } else if let satResponse = schoolSATResponse, let details = schoolDetail, (satResponse.count == 1) {
            lblSchoolName.text = satResponse[0].schoolName
            lblOverviewPara.text = details.overview_paragraph
            lblNumOfTestTakers.text = satResponse[0].numOfSatTestTakers ?? ""
            lblSatReadingScore.text = satResponse[0].satCriticalReadingAvgScore ?? ""
            lblSatMathScore.text = satResponse[0].satMathAvgScore ?? ""
            lblSatWritingScore.text = satResponse[0].satWritingAvgScore ?? ""
            lblLocation.text = details.location ?? ""
            lblPhoneNumber.text = details.phone_number ?? ""
            lblWebsite.text = details.website ?? ""
            lblEmail.text = details.school_email ?? ""
        } else {
            AlertWithOneOption(message: "No Data Found", optionOne: "Ok") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
