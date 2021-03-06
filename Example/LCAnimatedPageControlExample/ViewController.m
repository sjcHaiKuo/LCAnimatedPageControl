//
//  ViewController.m
//  LCAnimatedPageControl
//
//  Created by beike on 6/17/15.
//  Copyright (c) 2015 beike. All rights reserved.
//

#import "ViewController.h"
#import "LCAnimatedPageControl.h"
#import "IndicatorView.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) LCAnimatedPageControl *pageControl;
@property (assign, nonatomic) NSUInteger number;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    [self.collectionView layoutIfNeeded];
    self.number = 5;
    
    self.pageControl = [[LCAnimatedPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, 280, 20)];
    self.pageControl.center = CGPointMake(self.view.frame.size.width * 0.5f, _pageControl.center.y);
    self.pageControl.numberOfPages = _number;
    self.pageControl.indicatorDiameter = 8.0f;
    self.pageControl.indicatorMargin = 10.0f;
    self.pageControl.indicatorMultiple = 1.4;
    self.pageControl.pageStyle = LCScaleColorPageStyle;
    self.pageControl.pageIndicatorColor = [UIColor colorWithRed:176.0f/255.0f green:176.0f/255.0f blue:176.0f/255.0f alpha:1.0f];
    self.pageControl.currentPageIndicatorColor = [UIColor colorWithRed:221.0f/255.0f green:34.0f/255.0f blue:56.0f/255.0f alpha:1.0f];
    self.pageControl.sourceScrollView = _collectionView;
    [self.pageControl prepareShow];
    [self.view addSubview:_pageControl];
    
    
    /* ------autolayout-------- */
    
//    self.pageControl = [[LCAnimatedPageControl alloc] init];
//    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
//    self.pageControl.numberOfPages = _number;
//    self.pageControl.indicatorDiameter = 5.0f;// Required
//    self.pageControl.indicatorMargin = 18.0f;
//    self.pageControl.indicatorMultiple = 1.8f;
//    self.pageControl.pageStyle = ScaleColorPageStyle;
//    self.pageControl.pageIndicatorColor = [UIColor colorWithRed:176.0f/255.0f green:176.0f/255.0f blue:176.0f/255.0f alpha:1.0f];
//    self.pageControl.currentPageIndicatorColor = [UIColor colorWithRed:221.0f/255.0f green:34.0f/255.0f blue:56.0f/255.0f alpha:1.0f];
//    self.pageControl.sourceScrollView = _collectionView;
//    [self.pageControl prepareShow];
//    [self.view addSubview:_pageControl];
//    
//    [self.view addConstraints:@[
//                                [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
//                                [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
//                                [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
//                                [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
//                                ]];
//
//    [self.collectionView setContentOffset:CGPointMake(self.collectionView.bounds.size.width * 2, 0)];
    
    self.flowLayout.itemSize = CGSizeMake(self.collectionView.frame.size.width - 60, self.collectionView.frame.size.height - 100);
    [self.pageControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView reloadData];
    

//    
//    IndicatorView *view = [[IndicatorView alloc] init];
//    view.translatesAutoresizingMaskIntoConstraints = NO;
//    view.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:view];
//    
//    
//    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(view);
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:viewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:viewsDictionary]];

    
}


// If you want to scrollView to scroll to the non-adjacent location, Please realize the following protocol methods

//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;{
//    [self.pageControl clearIndicators];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)valueChanged:(LCAnimatedPageControl *)sender{
//    NSLog(@"%d", sender.currentPage);
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.frame.size.width * (sender.currentPage + 0)  , self.collectionView.contentOffset.y) animated:YES];
}

- (IBAction)buttonPress:(id)sender{
    if ([[(UIBarButtonItem *)sender title] isEqualToString:@"+"]) {
        self.number++;
    }
    else{
        if (self.number > 0) {
            self.number--;
        }
    }
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = _number;
}

#pragma mark  - UICollectionView DataSource

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _number;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width - 20, 400);
}


@end
