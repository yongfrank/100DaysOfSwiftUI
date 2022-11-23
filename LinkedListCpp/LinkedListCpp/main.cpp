//
//  main.cpp
//  LinkedListCpp
//
//  Created by Frank Chu on 10/9/22.
//

#include <iostream>

using namespace std;

/// C++ program for the linkedList
/// Node class to represent
/// a node of the linked list.
class Node {
public:
    int data;
    Node* next;
    
    // Default constructor
    Node() {
        data = 0;
        next = NULL;
    }
    
    // Parameterised Constructor
    Node(int data) {
        this->data = data;
        this->next = NULL;
    }
}

int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    return 0;
}
