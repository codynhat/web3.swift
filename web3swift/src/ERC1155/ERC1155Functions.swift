//
//  ERC1155Functions.swift
//  PLS-MVP
//
//  Created by Cody Hatfield on 7/9/20.
//

import Foundation
import BigInt

public enum ERC1155Functions {
	public struct balanceOf: ABIFunction {
        public static let name = "balanceOf"
        public let gasPrice: BigUInt?
        public let gasLimit: BigUInt?
        public var contract: EthereumAddress
        public let from: EthereumAddress?
        
        public let owner: EthereumAddress
		public let id: BigUInt
        
        public init(contract: EthereumAddress,
                    from: EthereumAddress? = nil,
                    gasPrice: BigUInt? = nil,
                    gasLimit: BigUInt? = nil,
                    owner: EthereumAddress,
					id: BigUInt) {
            self.contract = contract
            self.from = from
            self.gasPrice = gasPrice
            self.gasLimit = gasLimit
            self.owner = owner
			self.id = id
        }
        
        public func encode(to encoder: ABIFunctionEncoder) throws {
            try encoder.encode(owner)
			try encoder.encode(id)
        }
    }
}
