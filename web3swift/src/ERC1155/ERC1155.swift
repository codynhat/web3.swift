//
//  ERC1155.swift
//  PLS-MVP
//
//  Created by Cody Hatfield on 7/9/20.
//

import Foundation
import BigInt

public class ERC1155 {
	public let client: EthereumClient
	
	public init(client: EthereumClient) {
        self.client = client
    }
    
	public func balanceOf(tokenContract: EthereumAddress, address: EthereumAddress, tokenId: BigUInt, completion: @escaping((Error?, BigUInt?) -> Void)) {
		let function = ERC1155Functions.balanceOf(contract: tokenContract, owner: address, id: tokenId)
        function.call(withClient: self.client, responseType: ERC1155Responses.balanceResponse.self) { (error, balanceResponse) in
            return completion(error, balanceResponse?.value)
        }
    }
	
	public func safeTransferFrom(tokenContract: EthereumAddress, withAccount account: EthereumAccount, from: EthereumAddress, to: EthereumAddress, tokenId: BigUInt, amount: BigUInt, data: Data, gasPrice: BigUInt, gasLimit: BigUInt, completion: @escaping((Error?, String?) -> Void)) throws {
		let function = ERC1155Functions.safeTransferFrom(contract: tokenContract, gasPrice: gasPrice, gasLimit: gasLimit, _from: from, _to: to, _id: tokenId, _amount: amount, _data: data)
		let transaction = try function.transaction()
		self.client.eth_sendRawTransaction(transaction, withAccount: account, completion: completion)
    }
	
	public func allTransferSingleEvents(tokenContract: EthereumAddress, fromBlock: EthereumBlock, toBlock: EthereumBlock, completion: @escaping((Error?, [ERC1155Events.TransferSingle]?) -> Void)) {
        
		self.client.getEvents(addresses: [ tokenContract.value ],
                              topics: nil,
                              fromBlock: fromBlock,
                              toBlock: toBlock,
                              eventTypes: [ERC1155Events.TransferSingle.self]) { (error, events, unprocessedLogs) in
            
            if let events = events as? [ERC1155Events.TransferSingle] {
                return completion(error, events)
            } else {
                return completion(error ?? EthereumClientError.decodeIssue, nil)
            }
            
        }
    }
	
	public func allTransferBatchEvents(tokenContract: EthereumAddress, fromBlock: EthereumBlock, toBlock: EthereumBlock, completion: @escaping((Error?, [ERC1155Events.TransferBatch]?) -> Void)) {
        
		self.client.getEvents(addresses: [ tokenContract.value ],
                              topics: nil,
                              fromBlock: fromBlock,
                              toBlock: toBlock,
                              eventTypes: [ERC1155Events.TransferBatch.self]) { (error, events, unprocessedLogs) in
            
            if let events = events as? [ERC1155Events.TransferBatch] {
                return completion(error, events)
            } else {
                return completion(error ?? EthereumClientError.decodeIssue, nil)
            }
            
        }
    }
	
	public func allApprovalForAllEvents(tokenContract: EthereumAddress, fromBlock: EthereumBlock, toBlock: EthereumBlock, completion: @escaping((Error?, [ERC1155Events.ApprovalForAll]?) -> Void)) {
        
		self.client.getEvents(addresses: [ tokenContract.value ],
                              topics: nil,
                              fromBlock: fromBlock,
                              toBlock: toBlock,
                              eventTypes: [ERC1155Events.ApprovalForAll.self]) { (error, events, unprocessedLogs) in
            
            if let events = events as? [ERC1155Events.ApprovalForAll] {
                return completion(error, events)
            } else {
                return completion(error ?? EthereumClientError.decodeIssue, nil)
            }
            
        }
    }
}
