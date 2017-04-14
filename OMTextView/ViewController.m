//
//  ViewController.m
//  OMTextView
//
//  Created by 印聪 on 2017/4/14.
//  Copyright © 2017年 tima. All rights reserved.
//

#import "ViewController.h"
#import "OMTextView.h"
@interface ViewController ()

@property (nonatomic , strong)OMTextView *adviceTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.adviceTextView];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.adviceTextView.frame = CGRectMake(10, 30, self.view.bounds.size.width - 20, 100);
    
}


#pragma mark -- getters and setters
- (OMTextView *)adviceTextView{
    if (_adviceTextView == nil) {
        _adviceTextView = [[OMTextView alloc]init];
        _adviceTextView.layer.masksToBounds = YES;
        _adviceTextView.layer.cornerRadius = 2;
        _adviceTextView.layer.borderColor = [UIColor grayColor].CGColor;
        _adviceTextView.layer.borderWidth = 1.0f;
        _adviceTextView.omPlaceholder = @"123124142";
    }
    return _adviceTextView;
}




@end
