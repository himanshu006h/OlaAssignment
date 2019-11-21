//
//  MapDetailsModel.swift
//  OlaAssignment
//
//  Created by Himanshu Saraswat on 21/11/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation
struct MapDetailsModel : Codable {
	let id : String?
	let modelIdentifier : String?
	let modelName : String?
	let group : String?
	let licensePlate : String?
	let innerCleanliness : String?
	let carImageUrl : String?
	let vehicleDetails : VehicleDetails?
	let location : Location?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case modelIdentifier = "modelIdentifier"
		case modelName = "modelName"
		case group = "group"
		case licensePlate = "licensePlate"
		case innerCleanliness = "innerCleanliness"
		case carImageUrl = "carImageUrl"
		case vehicleDetails = "vehicleDetails"
		case location = "location"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		modelIdentifier = try values.decodeIfPresent(String.self, forKey: .modelIdentifier)
		modelName = try values.decodeIfPresent(String.self, forKey: .modelName)
		group = try values.decodeIfPresent(String.self, forKey: .group)
		licensePlate = try values.decodeIfPresent(String.self, forKey: .licensePlate)
		innerCleanliness = try values.decodeIfPresent(String.self, forKey: .innerCleanliness)
		carImageUrl = try values.decodeIfPresent(String.self, forKey: .carImageUrl)
		vehicleDetails = try values.decodeIfPresent(VehicleDetails.self, forKey: .vehicleDetails)
		location = try values.decodeIfPresent(Location.self, forKey: .location)
	}

}
