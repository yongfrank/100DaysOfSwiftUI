//
//  ViewController.m
//  Douyin
//
//  Created by Frank Chu on 5/11/23.
//

#import "ViewController.h"
#import "Douyin-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 300, 300)];
//    lb.text = @"hi";
//    lb.backgroundColor = [UIColor redColor];
//    [self.view addSubview:lb];
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"HI" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 200, 50);
    [self.view addSubview:btn];
    
}

- (void)buttonClicked {
//    UIViewController* vc = [SwiftUIViewFactory makeSwiftUIViewWithDismissHandler:^{
//        [[self presentedViewController] dismissViewControllerAnimated:YES completion:nil];
//    }];
    UIViewController *vc = [SwiftUIViewFactory makeUIKitView];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
