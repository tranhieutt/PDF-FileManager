//
//  AudioPlayerController.m
//  PDFFileManager
//
//  Created by ios15 on 9/3/13.
//
//

#import "AudioPlayerController.h"
#import <AVFoundation/AVFoundation.h>
@interface AudioPlayerController ()
{
    AVAudioPlayer *player;
    BOOL isPlaying;
    NSTimer *timer;
}
@end

@implementation AudioPlayerController
+ (id)initWithFilePath: (NSURL*) path;
{
    id object = [[[NSBundle mainBundle] loadNibNamed:@"AudioPlayerController" owner:self options:nil] lastObject];
    if ([object isKindOfClass:[AudioPlayerController class]]) {
        AudioPlayerController *pl = (AudioPlayerController*) object;
        pl.backgroundColor = [UIColor colorWithWhite:0.8f alpha:0.0f];
        NSError *error = nil;
        pl->player = [[AVAudioPlayer alloc] initWithContentsOfURL:path error:&error];
        pl->isPlaying = NO;
        [pl->player prepareToPlay];
        pl.progressBar.minimumValue = 0.0f;
        pl.progressBar.maximumValue = pl->player.duration;
        [pl.playBtn setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:pl action:@selector(handleTap:)];
        [pl addGestureRecognizer:tap];
        [pl setUserInteractionEnabled:YES];
        return pl;
    }
    return nil;
}


- (IBAction)playBtnTouch:(id)sender {
    if(isPlaying == NO){
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        [player play];
        if([timer isValid])
            [timer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    }else{
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [player pause];
    }
    isPlaying = !isPlaying;
}

- (IBAction)sliderValueChanged:(id)sender {
    player.currentTime = _progressBar.value;
    [_timeLb setText:[self convertTime:player.currentTime]];
}
- (void) handleTimer: (NSTimer *) timer
{
    _progressBar.value = player.currentTime;
    [_timeLb setText:[self convertTime:player.currentTime]];
    if(player.currentTime == player.duration){
        isPlaying = NO;
        [timer invalidate];
    }
}
- (NSString *) convertTime: (float) second
{
    int h = second/3600;
    int m = second/60;
    int s = (int)second%60;
    NSString *str = [NSString stringWithFormat:@"%d:%d:%d", h, m, s];
    return str;
}
- (void) handleTap: (UIPanGestureRecognizer *) pan
{
    [self removeFromSuperview];
}
@end
