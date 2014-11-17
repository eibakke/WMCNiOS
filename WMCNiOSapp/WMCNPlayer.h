//
//  WMCNPlayer.h
//  WMCNiOSapp
//
//  Created by Eivind Morris Bakke on 10/19/14.
//  Copyright (c) 2014 EivindMorrisBakke. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;

@interface WMCNPlayer : NSObject

@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL playerNeedsReloading;

+ (id)sharedInstance;

- (void)preparePlayer;
- (void)play;
- (void)pause;

@end
