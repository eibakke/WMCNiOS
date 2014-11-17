//
//  WMCNPlayer.m
//  WMCNiOSapp
//
//  Created by Eivind Morris Bakke on 10/19/14.
//  Copyright (c) 2014 EivindMorrisBakke. All rights reserved.
//

#import "WMCNPlayer.h"

@interface WMCNPlayer() {
    
}
@property (strong, nonatomic) AVPlayer *audioPlayer;
@property (strong, nonatomic) NSURL *WMCNURL;

@end

@implementation WMCNPlayer

- (id)init {
    self = [super init];
    if (self) {
        self.WMCNURL = [NSURL URLWithString:@"http://216.250.175.13:8000/"];
        self.audioPlayer = [[AVPlayer alloc]initWithURL:self.WMCNURL];
    }
    return self;
}

+ (id)sharedInstance {
    static WMCNPlayer *sharedWMCNPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWMCNPlayer = [[self alloc] init];
    });
    return sharedWMCNPlayer;
}

- (void)preparePlayer {
    if (self.playerNeedsReloading) {
        self.audioPlayer = nil;
        self.audioPlayer = [[AVPlayer alloc]initWithURL:self.WMCNURL];
        self.playerNeedsReloading = NO;
    }
}

- (void)play {
    if (self.audioPlayer.status == AVPlayerItemStatusReadyToPlay) {
        [self.audioPlayer play];
        self.isPlaying = YES;
    }
}

- (void)pause {
    [self.audioPlayer pause];
    self.isPlaying = NO;
}

@end
