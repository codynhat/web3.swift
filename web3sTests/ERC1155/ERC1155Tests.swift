//
//  ERC1155Tests.swift
//  web3swiftTests
//
//  Created by Cody Hatfield on 7/10/20.

import XCTest
import BigInt
@testable import web3swift

class ERC1155Tests: XCTestCase {
    var client: EthereumClient?
    var erc1155: ERC1155?
    let testContractAddress = EthereumAddress(TestConfig.erc1155Contract)
    
    override func setUp() {
        super.setUp()
        self.client = EthereumClient(url: URL(string: TestConfig.clientUrl)!)
        self.erc1155 = ERC1155(client: client!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAllTransferSingleEvents() {
        let expect = expectation(description: "Get transfer events to")
        
		erc1155?.allTransferSingleEvents(tokenContract: testContractAddress, fromBlock: .Earliest, toBlock: .Latest, completion: { (error, events) in
            XCTAssert(events!.count > 0)
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 10)
    }
    
}

