//
//  ViewController.m
//  ObjcUIKit
//
//  Created by Frank Chu on 4/9/23.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.layer.masksToBounds = true;
    self.imageView.layer.borderWidth = 2.0;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.secondImgView.layer.cornerRadius = 100;
    self.secondImgView.layer.borderWidth = 2.0;
    self.secondImgView.layer.borderColor = [UIColor whiteColor].CGColor;
}


@end
