//
//  ViewController.m
//  WMCNiOSapp
//
//  Created by Eivind Morris Bakke on 10/15/14.
//  Copyright (c) 2014 EivindMorrisBakke. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"

@interface ViewController () {
    BOOL playerIsPlaying;
    BOOL playerNeedsReloading;
}

@property (strong, nonatomic) WMCNPlayer *WMCNPlayer;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *playButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pauseButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setting up the audiosession which lets the app keep playing audio when in the background
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *setCategoryError = nil;
    BOOL success = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    if (!success) {
        /* handle the error condition */
    }
    NSError *activationError = nil;
    success = [audioSession setActive:YES error:&activationError];
    if (!success) {
        /* handle the error condition */
    }
    
    // For the remote actions from the lock screen
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    
    // For the artwork on the lock screen - set to keep the controls there when the player is paused from the lock screen
    UIImage *WMCNLogoImage = [UIImage imageNamed:@"WMCNLogo2"];
    MPMediaItemArtwork *mediaArtwork = [[MPMediaItemArtwork alloc]initWithImage:WMCNLogoImage];
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"WMCN", MPMediaItemPropertyTitle, mediaArtwork, MPMediaItemPropertyArtwork, nil];
    
    // The shared player we'll send messages to
    self.WMCNPlayer = [WMCNPlayer sharedInstance];
    
    self.pauseButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    if (event.type == UIEventTypeRemoteControl) {
        if (event.subtype == UIEventSubtypeRemoteControlPause) {
            [self pausePlayer];
        } else if (event.subtype == UIEventSubtypeRemoteControlPlay) {
            [self playPlayer];
        }
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)playPlayer {
    if (!self.WMCNPlayer.isPlaying) {
        [self.WMCNPlayer play];
        self.playButton.enabled = NO;
        self.pauseButton.enabled = YES;
    }
}

- (void)pausePlayer {
    if (self.WMCNPlayer.isPlaying) {
        [self.WMCNPlayer pause];
        self.playButton.enabled = YES;
        self.pauseButton.enabled = NO;
    }
}

- (void)showConnectionAlert {
    UIAlertView *connectionAlert = [[UIAlertView alloc] initWithTitle:@"Connection Failure"
                                                              message:@"Could not connect to WMCN stream"
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil,
                                    nil];
    
    [connectionAlert show];
    
}


- (IBAction)playButtonPressed:(id)sender {
    [self playPlayer];
}

- (IBAction)pauseButtonPressed:(id)sender {
    [self pausePlayer];
}


@end
