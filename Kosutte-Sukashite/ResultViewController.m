//
//  ResultViewController.m
//  Kosutte-Sukashite
//
//  Created by Tomi on 2015/08/12.
//  Copyright (c) 2015年 slj. All rights reserved.
//

#import "ResultViewController.h"
#import "ImobileSdkAds/ImobileSdkAds.h"
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"

@interface ResultViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //ラベルテキスト内容入力
    self.resultLabel.text = self.txt;
    
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

- (IBAction)backView:(id)sender {
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"main"];
    
    [self presentViewController:rootViewController animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
