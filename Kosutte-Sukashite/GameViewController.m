//
//  GameViewController.m
//  Kosutte-Sukashite
//
//  Created by Tomi on 2015/08/08.
//  Copyright (c) 2015年 slj. All rights reserved.
//

#import "GameViewController.h"
#import "ResultViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface GameViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *womanImage;
@property UILabel *label;
@property float alphaCnt;
@property (weak, nonatomic) IBOutlet UILabel *alphaLabel;
@property (nonatomic, strong) AVAudioEngine *engine;
@property (nonatomic, strong) AVAudioPlayerNode *audioPlayerNode;
@property (nonatomic, strong) AVAudioFile *audioFile;
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *imageName = [self getImageName];
    UIImage *imag = [UIImage imageNamed:imageName];
    self.womanImage.image = imag;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(update)
                                                userInfo:nil
                                                repeats:YES];
    self.time = 30;
    
    //画像透過値初期化
    _alphaCnt  = 0.0;
    self.womanImage.alpha = _alphaCnt;
    

    self.engine = [AVAudioEngine new];
    
    // [1] AVAudioFile オブジェクトを準備する
    NSString *path = [[NSBundle mainBundle] pathForResource:@"back_bgm" ofType:@"mp3"];
    self.audioFile = [[AVAudioFile alloc] initForReading:[NSURL fileURLWithPath:path]
                                                   error:nil];
    
    // [2] AVAudioPlayerNode オブジェクトを準備する
    self.audioPlayerNode = [AVAudioPlayerNode new];
    [self.engine attachNode:self.audioPlayerNode];
    
    // [3] Node 同士を繋ぐ
    AVAudioMixerNode *mixerNode = [self.engine mainMixerNode];
    [self.engine connect:self.audioPlayerNode
                      to:mixerNode
                  format:self.audioFile.processingFormat];
    
    // [4] Engine の処理を開始する
    NSError *error;
    [self.engine startAndReturnError:&error];
    if (error) {
        NSLog(@"error:%@", error);
    }
    
    // [5] オーディオファイルの再生をスケジュールする
    [self.audioPlayerNode scheduleFile:self.audioFile
                                atTime:nil
                     completionHandler:nil];
    
    // [6] 再生する
    [self.audioPlayerNode play];
    

}

- (void)update
{
    self.timerLabel.text = [NSString stringWithFormat:@"%d",self.time];
    
    if(self.time <= 0.0){
        [self.timer invalidate];
       
        ResultViewController *resultVC = [[ResultViewController alloc] init];
        
        resultVC.txt = [self getTxtByAlpahaCnt];
        
        [self presentViewController:resultVC animated:YES completion:nil];
        
        //BGM停止
        [self.audioPlayerNode stop];
        
    }else{
        self.time--;
        
    
        [self.label removeFromSuperview];
        
        //こすってラベルランダム表示
        CGRect r = [[UIScreen mainScreen] bounds];
        CGFloat w = r.size.width;
        CGFloat h = r.size.height;
        
        CGFloat x = arc4random_uniform(w);
        CGFloat y = arc4random_uniform(h);
        
        CGRect rect = CGRectMake(x, y, 100, 10);

        self.label = [[UILabel alloc] initWithFrame:rect];
        self.label.text = @"こすって！";
        
        [self.view addSubview:self.label];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//こすられた時の処理
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    _alphaCnt = _alphaCnt + 0.0005;
    self.womanImage.alpha =_alphaCnt;
    float num = _alphaCnt*100;
    NSString *str = [NSString stringWithFormat:@"%.f",num];
        
    self.alphaLabel.text = [str stringByAppendingString:@"%"];
    
}

-(NSString *)getImageName{
    int n = random() % 2;
    NSString *str =@"";
    switch (n) {
        case 0:
            str =@"w_woman2";
            return str;
            break;
            
        default:
            str =@"w_woman1";
            return str;
            break;
    }
}

-(NSString *)getTxtByAlpahaCnt{
    int num = _alphaCnt*100;
    NSString *str =@"";
    
    if (30 > num && num >=0){
        str = @"エロさが足りないわ";
    }
    
    if (50 > num && num >=30){
        str = @"見る気あるの";
    }
    
    if (80 > num && num >=50){
        str = @"なかなかの手つきね";
    }
    
    if (100> num && num >=80){
        str = @"す⭐︎て⭐︎き";
    }
    if(100 == num){
        str = @"ど変態♡";
    }

    return str;
    
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
