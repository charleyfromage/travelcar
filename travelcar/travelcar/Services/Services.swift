//
//  Services.swift
//  travelcar
//
//  Created by Fromage Charley on 06/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import Alamofire

class Services {
    func getCarsList(completion: @escaping ([Car], Error?) -> Void) {
        let urlString = Constants.APIs.serviceURL

        Alamofire.request(urlString).responseJSON { response in
            #if DEBUG
            print("Result: \(response.result.debugDescription)")
            #endif

            guard let data = response.data, let entity: [Car] = try? JSONDecoder().decode([Car].self, from: data) else {
                #if DEBUG
                print("Error parsing \([Car].self)")
                #endif

                return
            }

            completion(entity, response.error)
        }
    }
}
