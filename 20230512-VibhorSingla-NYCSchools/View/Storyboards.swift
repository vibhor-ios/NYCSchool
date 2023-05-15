//
//  Storyboards.swift
//  20230512-VibhorSingla-NYCSchools
//
//  Created by Vibhor Singla on 12/05/23.
//

import Foundation
import UIKit
class Storyboards {
    class func Main(controller: String) -> UIViewController {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: controller)
    }
}
