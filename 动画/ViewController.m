//
//  ViewController.m
//  动画
//
//  Created by  on 16/5/5.
//  Copyright © 2016年 . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSInteger _code;
}

@property(nonatomic,strong)UIImageView * headView;

@property(nonatomic,strong)NSTimer * time;

@property(nonatomic,strong)UIImageView * bottomView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 210, 60, 15)];
    bottomView.image = [UIImage imageNamed:@"3"];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;

    UIImageView * headView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
    [headView setImage:[UIImage imageNamed:@"1"]];
    [self.view addSubview:headView];
    self.headView = headView;

    _code = 1;
    
    NSTimer * time = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(animat) userInfo:nil repeats:YES];
    [time fire];
    self.time = time;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(100, 300, 100, 100);
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"停止" forState:UIControlStateNormal];
    [button setTitle:@"开始" forState:UIControlStateSelected];
    [self.view addSubview:button];
    
}

-(void)click:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        [self.headView removeFromSuperview];
        [self.bottomView removeFromSuperview];
        [self.time invalidate];
    }else{
        
        [self.view addSubview:self.bottomView];
        [self.view addSubview:self.headView];
        self.time = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(animat) userInfo:nil repeats:YES];
        [self.time fire];
    }
}

-(void)animat{
    _headView.alpha = 1;
    float num = arc4random() % 1000 / 1000.0;
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _headView.transform = CGAffineTransformRotate(CGAffineTransformMakeTranslation(0, 50), num * M_PI);
        self.bottomView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _headView.transform = CGAffineTransformMakeTranslation(0, 0);
            self.bottomView.transform = CGAffineTransformMakeScale(1, 1);
            _code = _code%3 + 1;
            switch (_code) {
                case 1:
                    [_headView setImage:[UIImage imageNamed:@"1"]];
                    break;
                case 2:
                    [_headView setImage:[UIImage imageNamed:@"01"]];
                    break;
                case 3:
                    [_headView setImage:[UIImage imageNamed:@"001"]];
                    break;
                    
                default:
                    break;
            }
        } completion:nil];
    }];
}

@end
