//
//  SchoolListResource.swift
//  20230512-VibhorSingla-NYCSchools
//
//  Created by Vibhor Singla on 12/05/23.
//

import Foundation
struct SchoolListResource {
    
    func getSchoolLists(completion: @escaping (_ result: [SchoolListModel]?, _ err: NetworkError?) -> Void) {
        guard let schoolListUrl = URL(string: APIEndPoints.schoolLists) else { return }
        let utility = HttpUtility.shared
        let schoolListRequest = Request(withUrl: schoolListUrl, forHttpMethod: .get)
        
        utility.request(huRequest: schoolListRequest, resultType: SchoolListModelString.self) { (response) in
            switch response
            {
            case .success(let schools):
                // code to handle the response
                do {
                    if let json = try schools?.jsonString(encoding: .utf8) {
                        if let data = json.replacingOccurrences(of: "\\", with: "").data(using: String.Encoding.utf8) {
                            do {
                                let decoder = JSONDecoder()
                                let responseModel = try decoder.decode([SchoolListModel].self, from: data)
                                completion(responseModel, nil)
                            } catch {
                                print(String(describing: error))
                               //NSLog("ERROR \(error.localizedDescription)")
                            }
                        }
                    } else {
                        print("No json Data found")
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                // your code here to handle error
                DispatchQueue.main.async {
                    LoadingIndicator.sharedInstance.hideActivityIndicator()
                    completion(nil, error)
                    // your code here to handle error
                    print(error.localizedDescription)
                }
                
                
            }
        }
    }
    
}
