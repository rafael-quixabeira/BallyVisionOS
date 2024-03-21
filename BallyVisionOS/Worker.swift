//
//  Worker.swift
//  BallyLiveForVisionOS
//
//  Created by Rafael Quixabeira on 18/03/24.
//  Copyright © 2024 Bally's Corporation. All rights reserved.
//

import Foundation

private actor NetworkHandler {
    static let shared = NetworkHandler()
    private init() {}

    func fetchData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

public class Worker {
    public static var shared: Worker = .init()
    private init() {}
    
    public func fetchMILBSchedule(
        startDate: Date,
        endDate: Date
    ) async -> MILBScheduleData? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)

        do {
            guard var urlComponents = URLComponents(string: "https://api-dev.dev2.ballylive.app/main/mlb/schedule") else {
                assertionFailure("unable to build a valid URL")
                return nil
            }

            urlComponents.queryItems = [
                URLQueryItem(name: "startDate", value: startDateString),
                URLQueryItem(name: "endDate", value: endDateString)
            ]

            // Create URL from components
            guard let url = urlComponents.url else {
                assertionFailure("unable to retrieve a valid URL")
                return nil
            }
            
            // Perform network request asynchronously
            let data = try await NetworkHandler.shared.fetchData(
                from: url
            )

            let result = try JSONDecoder().decode(
                [MILBScheduleData].self,
                from: data
            )
            
            print("result", result)

            return result.first
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
}
