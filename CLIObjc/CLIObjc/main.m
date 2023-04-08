//
//  main.m
//  CLIObjc
//
//  Created by Frank Chu on 4/9/23.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (assign) NSString *name;

- (instancetype)initWithName:(NSString*) name;
@end

@implementation Person

- (instancetype)initWithName: (NSString*) name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

- (BOOL)isEqualToPerson:(Person*)object {
    if (self.name == object.name) {
        return true;
    }
    return false;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *frank1 = [[Person alloc] initWithName:@"frank"];
        Person *frank2 = [[Person alloc] initWithName:@"frank"];
        if ([frank1 isEqual:frank2]) {
            NSLog(@"yeeees: %@", frank1.name);
        } else {
            NSLog(@"Not equal");
        }
        NSLog(@"[color1 isEqual:color2] = %@", [frank1 isEqual:frank2] ? @"YES" : @"NO");

    }
    return 0;
}
