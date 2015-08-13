//
//  GameViewController.h
//  Kosutte-Sukashite
//
//  Created by Tomi on 2015/08/08.
//  Copyright (c) 2015年 slj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController
@property  int time;
@property  NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@end
