//
//  PerformanceFunc.swift
//  SortPerformance
//
//  Created by Eugen Fedchenko on 8/24/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

import Foundation

let randGen = RandomIntGenerator(maxValue: 100)
let arraySize = 10000
let testCount = 100

/*
 * Check performance for direct Integer sorting
 */

func checkDirectSortAlgoPerf<G : SortIntAlg>(algo: G) -> PerformanceTiming {
    let sorter : (inout arr: [Int]) -> Void = { arr in
        algo.sort(&arr)
    }
    return measureSortPerformace(sorter, generator: randGen, arraySize: arraySize, testCount: testCount)
}

func checkSelectionIntFuncPerf() -> PerformanceTiming {
    return measureSortPerformace(selectionSortInt, generator: randGen, arraySize: arraySize, testCount: testCount)
    
}

func checkSelectionIntAlgoPerf() -> PerformanceTiming {
    return checkDirectSortAlgoPerf(SelectionSortIntAlg())
}

func checkMergeIntAlgoPerf() -> PerformanceTiming {
    return checkDirectSortAlgoPerf(MergeSortIntAlg())
}

func checkStdIntAlgoPerf() -> PerformanceTiming {
    return checkDirectSortAlgoPerf(StdLibSortIntAlg())
}

/*
 * Check performance for Generic sorting
 */

func checkSortAlgoPerformance<G: SortGenericAlg where G.Element == Int>(algo: G) -> PerformanceTiming {
    let sorter : (inout arr: [Int]) -> Void = { arr in
        algo.sort(&arr)
    }
    return measureSortPerformace(sorter, generator: randGen, arraySize: arraySize, testCount: testCount)
}

func checkSelectionGenericAlgoPerf() -> PerformanceTiming {
    return checkSortAlgoPerformance(SelectionSortGenericAlg<Int>())
}

func checkInsertionGenericAlgoPerf() -> PerformanceTiming {
    return checkSortAlgoPerformance(InsertionSortGenericAlg<Int>())
}

func checkMergeGenericAlgoPerf() -> PerformanceTiming {
    return checkSortAlgoPerformance(MergeSortGenericAlg<Int>())
}

func checkMergeExGenericAlgoPerfWithWindow_5() -> PerformanceTiming {
    return checkSortAlgoPerformance(MergeInsertionSortGenericAlg<Int>(windowSize: 5))
}

func checkMergeExGenericAlgoPerfWithWindow_10() -> PerformanceTiming {
    return checkSortAlgoPerformance(MergeInsertionSortGenericAlg<Int>(windowSize: 10))
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////
func runCheckPerformanceSet(funcs: [(String, () -> PerformanceTiming)]) {
    print("---------------------------------------------------")
    
    for (desc, f) in funcs {
        let t = f()
        print("\(desc) (best=\(t.best), worse=\(t.worse), mean=\(t.mean))")
    }
    
    print("---------------------------------------------------\n")
}


func compareDirectFuncAndStructCallsSorting() {
    
    print("Compare performance for direct functions and struct methods using Selection sort")
    
    let funcs = [
        ("Function", checkSelectionIntFuncPerf),
        ("Struct", checkSelectionIntAlgoPerf),
        ("Generic struct", checkSelectionGenericAlgoPerf),
    ]
    
    runCheckPerformanceSet(funcs)
}

func compareIntAndGenericSorting() {
    
    print("Compare performance for direct Int and generic <Int> calls using Merge sort")
    
    let funcs = [
        ("Direct", checkMergeIntAlgoPerf),
        ("Generic", checkMergeGenericAlgoPerf)
    ]
    
    runCheckPerformanceSet(funcs)
}



func compareSortAlgorithm() {
    
    print("Compare different sort algorithm performance")
    
    let funcs = [
        ("Selection", checkSelectionGenericAlgoPerf),
        ("Insertion", checkInsertionGenericAlgoPerf),
        ("Merge", checkMergeGenericAlgoPerf),
        ("Merge+Insertion (window size = 5)", checkMergeExGenericAlgoPerfWithWindow_5),
        ("Merge+Insertion (window size = 10)", checkMergeExGenericAlgoPerfWithWindow_10)
    ]
    
    runCheckPerformanceSet(funcs)
}
