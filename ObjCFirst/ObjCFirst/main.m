//
//  main.m
//  ObjCFirst
//
//  Created by Frank Chu on 9/12/22.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject
{
    double accumulator;
}
-(void) setAccumulator: (double) value;
-(void) clear;

-(void) add: (double) value;
-(void) subtract: (double) value;
-(void) multiply: (double) value;
-(void) divide: (double) value;

-(double) showResult;
@end

@implementation Calculator
-(void) clear {
    accumulator = 0;
}
-(void) setAccumulator:(double)value {
    accumulator = value;
}

-(void) add: (double)value {
    accumulator += value;
}
-(void) subtract: (double) value {
    accumulator -= value;
}
-(void) multiply: (double) value {
    accumulator *= value;
}
-(void) divide: (double) value {
    accumulator /= value;
}

-(double) showResult {
    return accumulator;
}


@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Calculator *deskCalc;
        deskCalc = [[Calculator alloc] init];
        [deskCalc clear];
        [deskCalc setAccumulator: 100.0];
        [deskCalc add: 200.];
        [deskCalc divide: 15.0];
        [deskCalc subtract: 10.0];
        [deskCalc multiply: 5];
        
        double res = [deskCalc showResult];
        NSLog(@"The result is: %g", res);
    }
    return 0;
}
