//
//  ERC1155Events.swift
//  PLS-MVP
//
//  Created by Cody Hatfield on 7/10/20.
//

import Foundation
import BigInt

public enum ERC1155Events {
    public struct TransferSingle: ABIEvent {
        public static let name = "TransferSingle"
        public static let types: [ABIType.Type] = [ EthereumAddress.self , EthereumAddress.self , EthereumAddress.self, BigUInt.self, BigUInt.self]
        public static let typesIndexed = [true, true, true, false, false]
        public let log: EthereumLog
		
		public let _operator: EthereumAddress
        public let from: EthereumAddress
        public let to: EthereumAddress
        public let id: BigUInt
		public let amount: BigUInt
        
        public init?(topics: [ABIType], data: [ABIType], log: EthereumLog) throws {
            try TransferSingle.checkParameters(topics, data)
            self.log = log
            
			self._operator = try topics[0].decoded()
            self.from = try topics[1].decoded()
            self.to = try topics[2].decoded()
            
            self.id = try data[0].decoded()
			self.amount = try data[1].decoded()
        }
    }
}
