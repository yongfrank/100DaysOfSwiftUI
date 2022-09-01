//
//  ViewController.m
//  ByteDanceCamp_Demo
//
//  Created by Frank Chu on 7/22/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    // Do any additional setup after loading the view.
    
    MyClass *instanceOfMyClass = [[MyClass alloc] init];
    
    int result = [instanceOfMyClass myInstanceMethod];
    NSLog(@"%d", result);
    
}

@end
