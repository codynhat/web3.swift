//
//  ERC1155Responses.swift
//  PLS-MVP
//
//  Created by Cody Hatfield on 7/9/20.
//

import Foundation
import BigInt

public enum ERC1155Responses {
	public struct balanceResponse: ABIResponse {
        public static var types: [ABIType.Type] = [ BigUInt.self ]
        public let value: BigUInt
        
        public init?(values: [ABIType]) throws {
            self.value = try values[0].decoded()
        }
    }
}
