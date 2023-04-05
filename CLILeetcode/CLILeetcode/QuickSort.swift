//
//  QuickSort.swift
//  CLILeetcode
//
//  Created by Frank Chu on 2/22/23.
//

import Foundation

class Solution {
    // 剑指 Offer 21. 调整数组顺序使奇数位于偶数前面
    func exchangeHOF(_ nums: [Int]) -> [Int] {
        return nums.filter({ $0 % 2 == 1 }) + nums.filter({ $0 % 2 == 0 })
    }
    
    func exchange(_ nums: [Int]) -> [Int] {
        var nums = nums
        var left = 0
        var right = nums.count - 1
        
        while left < right {
            while nums[left] & 1 == 1 && left < right {
                left += 1
            }
            while nums[right] & 1 == 0 && left < right {
                right -= 1
            }
            nums.swapAt(left, right)
            left += 1
            right -= 1
        }
        
        return nums
    }
    
    func test() {
        print("Test Case 0", self.exchange([1, 2, 3, 4]))
        print("Test Case 1", self.exchange([1, 3, 3]))
    }
}
