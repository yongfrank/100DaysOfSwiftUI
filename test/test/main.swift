// 本题为考试多行输入输出规范示例，无需提交，不计分。
import Foundation
let n = Int(readLine()!)!
var ans = 0;
for _ in 0 ..< n {
    if let line = readLine() {
        let parts = line.split(separator: " ")
        print("DEBUG: ", parts)
        for part in parts {
            ans += Int(part)!
        }
    }
}
print(ans)
