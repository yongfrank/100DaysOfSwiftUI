//
//  ViewController.m
//  DouyinObjc
//
//  Created by Chu Yong on 5/13/23.
//

#import "ViewController.h"
#import <SDWebImage/SDWebImage.h>

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray <NSArray *>*sections;
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    // UICollectionView
    self.sections = [NSMutableArray array];
    [self.sections addObject:@[@"123"]];
    [self.sections addObject:@[@"3", @"4"]];
    [self.sections addObject:@[@"3", @"4", @"3", @"4"]];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    layout.itemSize = CGSizeMake(100, 200);
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 50, 0);
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
//    [self.view addSubview:collectionView];
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *image = [UIImage systemImageNamed:@"questionmark.circle"];
//    UIImage *image = [UIImage imageNamed:@"download"];
    [self.view addSubview:self.button];
    [imageButton setHidden:NO];
//    [imageButton setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];

//    [imageButton setTitle:@"查看示例" forState:UIControlStateNormal];
//    [imageButton addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    self.button.frame = CGRectMake(20, 120, 100, 50);
    [self.view setBackgroundColor:[UIColor grayColor]];
    
}

- (void)buttonTapped {
    NSLog(@"hi");
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sections[section].count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    label.text = self.sections[indexPath.section][indexPath.row];
    [cell addSubview:label];
    
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


+ (void)load {
    [super load];
    NSLog(@"1");
}

- (void)loadView {
    [super loadView];
    NSLog(@"2");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"4");
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"5");
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"6");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"7");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"8");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"9");
}

- (void)dealloc {
    NSLog(@"10");
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_button setTitle:@"HI" forState:UIControlStateNormal];
//        _button.titleLabel.textColor = [UIColor greenColor];
//        [_button setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
        [_button sd_setImageWithURL:[NSURL URLWithString:@"https://resource.51downapp.cn/hb_lego_circle.png"] forState:UIControlStateNormal];
//        [_button.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://resource.51downapp.cn/hb_lego_circle.png"]];
//        _button.imageView.frame = CGRectMake(0, 0, 30, 30);
//        _button.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        _button.imageView.backgroundColor = [UIColor redColor];
    }
    return _button;
}
@end
