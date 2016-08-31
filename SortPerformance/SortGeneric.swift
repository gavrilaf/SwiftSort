//
//  SortGeneric.swift
//  SortPerformance
//
//  Created by Eugen Fedchenko on 8/24/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

import Foundation

protocol SortGenericAlg {
    associatedtype Element
    
    func sort(inout arr : [Element]) -> Void
}


/*
 * Selection sort
 */

struct SelectionSortGenericAlg <Element: Comparable> : SortGenericAlg {
    func sort(inout arr : [Element]) -> Void {
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


/*
 * Insertion sort
 */

struct InsertionSortGenericAlg <Element: Comparable> : SortGenericAlg {
    func sort(inout arr : [Element]) -> Void {
        let size = arr.count
        guard size > 0 else { return }
        
        for i in 1..<size {
            let key = arr[i]
            var j = i - 1;
            while j >= 0 && arr[j] > key {
                arr[j + 1] = arr[j]
                j -= 1
            }
            arr[j + 1] = key;
        }
    }
}

/*
 * Merge sort
 */

struct MergeSortGenericAlg <Element: Comparable> : SortGenericAlg {
    func sort(inout arr : [Element]) -> Void {
        innnerSort(&arr, left: 0, right: arr.count - 1)
    }
    
    private func innnerSort(inout arr: [Element], left: Int, right: Int)
    {
        if left < right {
            let middle = (left + right) / 2;
            innnerSort(&arr, left: left, right: middle)
            innnerSort(&arr, left: middle+1, right: right)
            merge(&arr, left: left, middle: middle, right: right)
        }
    }
    
    private func merge(inout arr: [Element], left: Int, middle: Int, right: Int) {
        let leftArr: [Element] = Array(arr[left...middle])
        let rightArr: [Element] = Array(arr[middle + 1...right])
        
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

/*
 * Merge+Insertion sort
 * Merge sort but for short subarrays use Insertion sort
 */

struct MergeInsertionSortGenericAlg <Element: Comparable> : SortGenericAlg {
    
    let windowSize : Int
    
    init(windowSize: Int) {
        self.windowSize = windowSize
    }
    
    func sort(inout arr : [Element]) -> Void {
        innnerSort(&arr, left: 0, right: arr.count - 1)
    }
    
    private func innnerSort(inout arr: [Element], left: Int, right: Int)
    {
        let dist = right - left
        
        if dist > windowSize {
            let middle = (left + right) / 2;
            innnerSort(&arr, left: left, right: middle)
            innnerSort(&arr, left: middle+1, right: right)
            merge(&arr, left: left, middle: middle, right: right)
        } else if dist > 0 {
            inPlaceInsertionSort(&arr, left: left, right: right)
        }
    }
    
    private func inPlaceInsertionSort(inout arr: [Element], left: Int, right: Int) {
        for i in left+1...right {
            let key = arr[i]
            var j = i - 1;
            while j >= 0 && arr[j] > key {
                arr[j + 1] = arr[j]
                j -= 1
            }
            arr[j + 1] = key;
        }
    }
    
    private func merge(inout arr: [Element], left: Int, middle: Int, right: Int) {
        let leftArr: [Element] = Array(arr[left...middle])
        let rightArr: [Element] = Array(arr[middle + 1...right])
        
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


/*
 * Quick sort
 */

struct QuickSortGenericAlg <Element: Comparable> : SortGenericAlg {

    func sort(inout arr : [Element]) -> Void {
    
    }
}
