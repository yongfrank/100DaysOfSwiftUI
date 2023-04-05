//
//  MarkdownView.swift
//  ScriptNodeParody
//
//  Created by Frank Chu on 3/25/23.
//

import SwiftUI
import MarkdownUI

struct MarkdownView: View {
    private let content = """
        # This is title
        
        > You can call out code or a command within a sentence with single backticks.
        The text within the backticks will not be formatted.
        
        ```
        Use `git status` to list all new or modified files that haven't yet been committed.
        ```
        
        Use `git status` to list all new or modified files that haven't yet been committed.
        To format code or text into its own distinct block, either use triple backticks
        (` ``` `) or indent each line by 4 spaces.
        
        After creating a group, any modifier you apply to the group affects
        all of that group’s members.
        
        ```swift
        Group {
            Text("SwiftUI")
            Text("Combine")
            Text("Swift System")
        }
        .font(.headline)
        ```
        | 0| 1|
        |-|-|
        |12|34|
        
        After creating a group, any modifier you apply to the group affects
        all of that group’s members.
        
        ```swift
        Group {
            Text("SwiftUI")
            Text("Combine")
            Text("Swift System")
        }
        .font(.headline)
        ```
        """
    
    var body: some View {
        ScrollView {
            Markdown(content)
                .markdownBlockStyle(\.blockquote) { configuration in
                  configuration.label
                    .padding()
                    .markdownTextStyle {
                      FontCapsVariant(.lowercaseSmallCaps)
                      FontWeight(.semibold)
                      BackgroundColor(nil)
                    }
                    .overlay(alignment: .leading) {
                      Rectangle()
                        .fill(Color.teal)
                        .frame(width: 4)
                    }
                    .background(Color.teal.opacity(0.5))
                }
                .markdownTheme(.docC)
                .padding()
        }
    }
}

struct MarkdownView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownView()
    }
}
