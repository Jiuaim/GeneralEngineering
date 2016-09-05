//
//  SZLoginViewController.m
//  General
//
//  Created by llbt on 16/9/1.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "SZLoginViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "SZTabBarController.h"

@interface SZLoginViewController ()

@property (strong, nonatomic) IJKFFMoviePlayerController *player;

@end

@implementation SZLoginViewController

- (void)dealloc {
    NSLog(@"%s --- %@",__func__,NSStringFromClass([self class]));
}

- (IJKFFMoviePlayerController *)player {
    if (!_player) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"loginmovie" ofType:@"mp4"];
        _player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:path withOptions:[IJKFFOptions optionsByDefault]];
        _player.view.frame = self.view.bounds;
        _player.scalingMode = IJKMPMovieScalingModeAspectFill;
        _player.shouldAutoplay = NO;
        [_player prepareToPlay];
    }
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    [self addObserver];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player.view removeFromSuperview];
    self.player = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupSubViews {
    WEAK(self)
    [self.view addSubview:self.player.view];
    UIButton *speedLogin = [[UIButton alloc] init];
    [speedLogin setTitle:@"快速登录" forState:UIControlStateNormal];
    [speedLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [speedLogin bk_addEventHandler:^(id sender) {
        [self.player.view removeFromSuperview];
        SZTabBarController *tabBar = [[SZTabBarController alloc] init];
        [UIWindow lastWindow].rootViewController = tabBar;
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *statuChange = [[UIButton alloc] init];
    [statuChange setTitle:@"暂停" forState:UIControlStateNormal];
    [statuChange setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [statuChange bk_addEventHandler:^(id sender) {
        UIButton *button = (UIButton *)sender;
        button.selected = !button.selected;
        NSString *statuString = !button.selected ? @"暂停" : @"开始";
        [statuChange setTitle:statuString forState:UIControlStateNormal];
        if (!button.selected) {
            [weakself.player play];
        } else {
            [weakself.player pause];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:speedLogin];
    [self.view addSubview:statuChange];
    
    [speedLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
    }];
    [statuChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(speedLogin);
        make.top.equalTo(speedLogin.mas_bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
    }];
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
}


#pragma mark -- observer
- (void)didFinish {
    [self.player play];
}

- (void)stateDidChange {
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.player.isPlaying) {
            [self.player play];
        }
    }
}
@end
