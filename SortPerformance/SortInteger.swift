//
//  SortWithInt.swift
//  SortPerformance
//
//  Created by Eugen Fedchenko on 8/23/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

import Foundation

protocol SortIntAlg {
    func sort(inout arr : [Int]) -> Void
}

/*
 * Selection sort
 */

struct SelectionSortIntAlg : SortIntAlg {
    func sort(inout arr : [Int]) -> Void {
        let size = arr.count
        
        for i in 0..<size {
            var smallestIndx = i
            var smallest = arr[i]
            for j in i+1..<size {
                if arr[j] < smallest {
                    smallestIndx = j
                    smallest = arr[j]
                }
            }
            if i != smallestIndx {
                let t = arr[i]
                arr[i] = arr[smallestIndx]
                arr[smallestIndx] = t
            }
        }

    }
}

func selectionSortInt(inout arr : [Int]) -> Void
{
    let size = arr.count
    
    for i in 0..<size {
        var smallestIndx = i
        var smallest = arr[i]
        for j in i+1..<size {
            if arr[j] < smallest {
                smallestIndx = j
                smallest = arr[j]
            }
        }
        if i != smallestIndx {
            let t = arr[i]
            arr[i] = arr[smallestIndx]
            arr[smallestIndx] = t
        }
    }
}

/*
 * Merge sort
 */

struct MergeSortIntAlg : SortIntAlg {
    func sort(inout arr : [Int]) -> Void {
        innnerSort(&arr, left: 0, right: arr.count - 1)
    }
    
    private func innnerSort(inout arr: [Int], left: Int, right: Int)
    {
        if left < right {
            let middle = (left + right) / 2;
            innnerSort(&arr, left: left, right: middle)
            innnerSort(&arr, left: middle+1, right: right)
            merge(&arr, left: left, middle: middle, right: right)
        }
    }
    
    private func merge(inout arr: [Int], left: Int, middle: Int, right: Int) {
        let leftArr: [Int] = Array(arr[left...middle])
        let rightArr: [Int] = Array(arr[middle + 1...right])
        
        let leftArrSize = leftArr.count
        let rightArrSize = rightArr.count
        
        var i = 0, j  = 0, k = left
        while i < leftArrSize && j < rightArrSize {
            if leftArr[i] <= rightArr[j] {
                arr[k] = leftArr[i]
                i += 1
            } else {
                arr[k] = rightArr[j]
                j += 1
            }
            k += 1
        }
        
        while i < leftArrSize {
            arr[k] = leftArr[i]
            i += 1
            k += 1
        }
        
        while j < rightArrSize {
            arr[k] = rightArr[j]
            j += 1
            k += 1
        }
    }
}





