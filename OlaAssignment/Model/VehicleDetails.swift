//
//  VehicleDetails.swift
//  OlaAssignment
//
//  Created by Himanshu Saraswat on 21/11/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation
struct VehicleDetails : Codable {
	let name : String?
	let make : String?
	let color : String?
	let series : String?
	let fuel_type : String?
	let fuel_level : Double?
	let transmission : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case make = "make"
		case color = "color"
		case series = "series"
		case fuel_type = "fuel_type"
		case fuel_level = "fuel_level"
		case transmission = "transmission"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		make = try values.decodeIfPresent(String.self, forKey: .make)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		series = try values.decodeIfPresent(String.self, forKey: .series)
		fuel_type = try values.decodeIfPresent(String.self, forKey: .fuel_type)
		fuel_level = try values.decodeIfPresent(Double.self, forKey: .fuel_level)
		transmission = try values.decodeIfPresent(String.self, forKey: .transmission)
	}

}
