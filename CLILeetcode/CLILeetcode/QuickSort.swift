//
//  QuickSort.swift
//  CLILeetcode
//
//  Created by Frank Chu on 2/22/23.
//

import Foundation

class Solution {
    func merge(nums: inout [Int], start: Int, mid: Int, end: Int) {
        print(start, mid, end)
        var leftArray = [Int]()
        var rightArray = [Int]()
        for i in start ..< mid + 1 {
            leftArray.append(nums[i])
        }
        for i in mid + 1 ..< end + 1 {
            rightArray.append(nums[i])
        }
        var i = 0
        var j = 0
        var k = start
        while i < leftArray.count && j < rightArray.count {
            if leftArray[i] > rightArray[j] {
                nums[k] = rightArray[j]
                j += 1
            } else {
                nums[k] = leftArray[i]
                i += 1
            }
            k += 1
        }
        while i < leftArray.count {
            nums[k] = leftArray[i]
            i += 1
            k += 1
        }
        while j < rightArray.count {
            nums[k] = rightArray[j]
            j += 1
            k += 1
        }
    }
    func mergeSort(nums: inout [Int], start: Int, end: Int) {
        if start >= end {
            return
        }
        let mid = (start + end) / 2
        mergeSort(nums: &nums, start: start, end: mid)
        mergeSort(nums: &nums, start: mid + 1, end: end)
        merge(nums: &nums, start: start, mid: mid, end: end)
    }
    func test() {
        var nums = [1, 5, 39, 32, 2, 9, 8, 3, 2, 2]
        mergeSort(nums: &nums, start: 0, end: nums.count - 1)
        print(nums)
    }
}
