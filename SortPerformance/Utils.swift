//
//  Utils.swift
//  SortPerformance
//
//  Created by Eugen Fedchenko on 8/23/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

import Foundation

func isSorted<T: Comparable>(_ a: [T], precede: (T, T) -> Bool) -> Bool
{
    let size = a.count
    guard size > 0 else { return true }
    
    for indx in 0..<a.count-1 {
        if !precede(a[indx], a[indx+1]) {
            return false
        }
    }
    
    return true
}

func measureCallTime(_ f: () -> Void) -> Double
{
    let startTime = CFAbsoluteTimeGetCurrent()
    f()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    return Double(timeElapsed)
}

struct PerformanceTiming {
    let best: Double
    let worse: Double
    let mean: Double
}

func measureSortPerformace<T, G : SimpleRandomGenerator>(sortFunc: @escaping (inout [T]) -> Void,
                           generator: G,
                           arraySize: Int,
                           testCount: Int) -> PerformanceTiming where G.Value == T
{
    var meanTime = 0.0, worseTime = 0.0, bestTime = Double(Int.max)
    
    (0..<testCount).forEach {i in
        
        var ar = generator.generateArray(size: arraySize)
        let tm = measureCallTime { sortFunc(&ar) }
        
        if tm > worseTime {
            worseTime = tm
        }
        
        if tm < bestTime {
            bestTime = tm
        }
        
        meanTime += tm
    }
    
    meanTime /= Double(testCount)
    
    return PerformanceTiming(best: bestTime*1000.0, worse: worseTime*1000.0, mean: meanTime*1000.0)
}

