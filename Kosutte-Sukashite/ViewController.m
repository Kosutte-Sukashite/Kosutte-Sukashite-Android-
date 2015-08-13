//
//  ViewController.m
//  Kosutte-Sukashite
//
//  Created by Tomi on 2015/08/08.
//  Copyright (c) 2015年 slj. All rights reserved.
//

#import "ViewController.h"
#import "ImobileSdkAds/ImobileSdkAds.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //広告表示
    [ImobileSdkAds registerWithPublisherID:@"21189" MediaID:@"196164" SpotID:@"547735"];
    [ImobileSdkAds startBySpotID:@"547735"];
    CGRect r = [[UIScreen mainScreen] bounds];
    CGFloat x = 0.0;
    CGFloat y = r.size.height - 50;
    [ImobileSdkAds showBySpotID:@"547735" ViewController:self Position:CGPointMake(x,y) SizeAdjust:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
