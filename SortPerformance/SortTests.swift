//
//  SortTests.swift
//  SortPerformance
//
//  Created by Eugen Fedchenko on 8/25/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

import Foundation

let testCases = [
    ("Just array", [1, 43, 32, 200, 1]),
    ("A bit longer array", [1, 43, 32, 200, 1, 12, 1, 43, 32, 200, 1, 12, 1, 43, 32, 200, 1, 12, 1, 43, 32, 200, 1, 12]),
    ("Reverse sorted", [5, 4, 3, 2, 1]),
    ("Equal array", [5, 5, 5, 5, 5]),
    ("One element array", [1]),
    ("Empty array", [])
]

/*
 * Integer
 */

func testSelectionSortIntFunc() -> Void {
    
    print("Selection sort for Integer type (use function)")
    for (test, data) in testCases {
        var data2 = data
        selectionSortInt(&data2)
        
        print("Testing \(test) -> \(isSorted(data2, precede: (<=)))")
    }
}

func testSelectionSortIntAlgo() -> Void {
    
    print("Selection sort for Integer type")
    
    let algo = SelectionSortIntAlg()
    for (test, data) in testCases {
        var data2 = data
        algo.sort(&data2)
        
        print("Testing \(test) -> \(isSorted(data2, precede: (<=)))")
    }
}

func testMergeSortIntAlgo() -> Void {
    
    print("Merge sort for Integer type")
    
    let algo = MergeSortIntAlg()
    for (test, data) in testCases {
        var data2 = data
        algo.sort(&data2)
        
        print("Testing \(test) -> \(isSorted(data2, precede: (<=)))")
    }
}

/*
 * Generic
 */

func testGenericSort<G: SortGenericAlg>(_ desc: String, algo: G) -> Void where G.Element == Int {
    print("\(desc) (Generic)")
    
    for (test, data) in testCases {
        var data2 = data
        algo.sort(&data2)
        
        print("Testing \(test) -> \(isSorted(data2, precede: (<=)))")
    }
}

func testSelectionSortGenericAlgo() -> Void {
    
    testGenericSort("Selection", algo: SelectionSortGenericAlg<Int>())
}

func testInsertionSortGenericAlgo() -> Void {
    
    testGenericSort("Insertion", algo: InsertionSortGenericAlg<Int>())
}

func testMergeSortGenericAlgo() -> Void {
    
    testGenericSort("Merge", algo: MergeSortGenericAlg<Int>())
}

func testMergeExSortGenericAlgo() -> Void {
    
    testGenericSort("Merge+Insertion", algo: MergeInsertionSortGenericAlg<Int>(windowSize: 5))
}

func testDeterministicQuicksortGenericAlgo() -> Void {
    
    testGenericSort("Quick (Deterministic)", algo: DeterministicQuicksortAlg<Int>())
}

func testRandomQuicksortGenericAlgo() -> Void {
    
    testGenericSort("Quick (Random)", algo: DeterministicQuicksortAlg<Int>())
}



//////////////////////////////////////////////////////////////////////////////////////

func runAllTestCases() -> Void {
    let tests = [
       // testSelectionSortIntFunc,
       // testSelectionSortIntAlgo,
       // testMergeSortIntAlgo,
       // testSelectionSortGenericAlgo,
       // testInsertionSortGenericAlgo,
       // testMergeSortGenericAlgo,
       // testMergeExSortGenericAlgo,
        testDeterministicQuicksortGenericAlgo,
        testRandomQuicksortGenericAlgo
    ]
    
    for f in tests {
        print("****** Test case ******")
        f()
        print("***********************\n")
    }
}
