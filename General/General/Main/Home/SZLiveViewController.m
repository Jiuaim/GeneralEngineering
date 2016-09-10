//
//  SZLiveViewController.m
//  General
//
//  Created by llbt on 16/9/9.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "SZLiveViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface SZLiveViewController ()
@property (nonatomic, strong) IJKFFMoviePlayerController *palyer;
@end

@implementation SZLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    _palyer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_user.flv withOptions:options];
    _palyer.view.frame = self.view.bounds;
    _palyer.scalingMode = IJKMPMovieScalingModeAspectFill;
    _palyer.shouldAutoplay = NO;
    _palyer.shouldShowHudView = NO;
    [self.view insertSubview:_palyer.view atIndex:0];
    
    [_palyer prepareToPlay];
    [self initObserver];
}

- (void)initObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.palyer];
}


- (void)stateDidChange {
    if ((self.palyer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.palyer.isPlaying) {
            [self.palyer play];
        }else{
            
        }
    }
}

@end
