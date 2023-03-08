//: [Previous](@previous)

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class Solution {
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if preorder.count == 0 {
            return nil
        }
        if preorder.count == 1 {
            return TreeNode(preorder[0])
        }
        if let first = preorder.first {
            var root: TreeNode = TreeNode(first)
            if let indexInInorder = inorder.firstIndex(of: first) {
                var ino = Array(inorder[..<indexInInorder])
                var pre = Array(preorder[1..<(1 + indexInInorder)])
                root.left = buildTree(pre, ino)
                ino = Array(inorder[(indexInInorder + 1)...])
                pre = Array(preorder[(1 + indexInInorder)...])
                root.right = buildTree(pre, ino)
                return root
            }
        }
        
        return nil
    }
}
func test1() {
    dump(Solution().buildTree([3, 9, 20, 15, 7], [9, 3, 15, 20, 7]))
}
var arr = [1, 2]
print(Array(arr[..<2]))

//: [Next](@next)
