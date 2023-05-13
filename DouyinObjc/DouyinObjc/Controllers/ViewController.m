//
//  ViewController.m
//  DouyinObjc
//
//  Created by Chu Yong on 5/13/23.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"Hello World";
    [self.view addSubview:label];
}
@end
