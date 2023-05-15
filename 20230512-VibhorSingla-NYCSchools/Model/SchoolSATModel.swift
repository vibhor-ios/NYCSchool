//
//  SchoolSATModel.swift
//  20230512-VibhorSingla-NYCSchools
//
//  Created by Vibhor Singla on 12/05/23.
//

import Foundation
// MARK: - SchoolSATModelElement
struct SchoolSATModelElement: Codable {
    let dbn, schoolName, numOfSatTestTakers, satCriticalReadingAvgScore: String?
    let satMathAvgScore, satWritingAvgScore: String?

    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}

typealias SchoolSATModel = [SchoolSATModelElement]
