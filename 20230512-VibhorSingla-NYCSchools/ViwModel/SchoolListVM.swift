//
//  SchoolListVM.swift
//  20230512-VibhorSingla-NYCSchools
//
//  Created by Vibhor Singla on 12/05/23.
//

import Foundation
protocol SchoolListVMDelegate {
    func didReceiveSchoolListResponse(schoolListResponse: [SchoolListModel]?, err: NetworkError?)
}

class SchoolListVM {
    var schoolListVmDelegate : SchoolListVMDelegate?
    
    func getSchoolList() {
        // use SchoolListResource to call API
        LoadingIndicator.sharedInstance.showActivityIndicator()
        let schoolListResource = SchoolListResource()
        schoolListResource.getSchoolLists { result,err  in
            // return the response we get from SchoolListResource
            DispatchQueue.main.async {
                LoadingIndicator.sharedInstance.hideActivityIndicator()
                self.schoolListVmDelegate?.didReceiveSchoolListResponse(schoolListResponse: result, err: err)
            }
        }
    }
}
