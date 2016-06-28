//
//  AGTBelenViewController.m
//  AngryEsteban
//
//  Created by Alicia Daza on 19/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import "AGTBelenViewController.h"
#import "AGTSystemSounds.h"

@interface AGTBelenViewController ()

@property (strong, nonatomic) UIImageView *lastShot;

@property (strong, nonatomic) NSArray *showSprite;
@property (strong, nonatomic) NSArray *hideSprite;
@property (strong, nonatomic) UIImageView *tapeView;
@property (nonatomic) CGPoint lastTouch;

@end

@implementation AGTBelenViewController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = @"Angry Esteban";
    
    //Sprites
    self.showSprite = @[[UIImage imageNamed:@"tape1.png"],
                        [UIImage imageNamed:@"tape2.png"],
                        [UIImage imageNamed:@"tape3.png"],
                        [UIImage imageNamed:@"tape4.png"]];
    
    self.hideSprite = @[[UIImage imageNamed:@"tape4.png"],
                        [UIImage imageNamed:@"tape3.png"],
                        [UIImage imageNamed:@"tape2.png"],
                        [UIImage imageNamed:@"tape1.png"]];
    
    //Create recognizers
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget: self
                                   action: @selector (didTap:)];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                   initWithTarget: self
                                   action: @selector (didPan:)];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]
                                       initWithTarget: self
                                       action: @selector (didSwipe:)];
    
    //Add gesture recognizers to view
    [self.view addGestureRecognizer:tap];
    [self.view addGestureRecognizer:pan];
    [self.view addGestureRecognizer:swipe];
}

#pragma mark - Actions
- (void) didTap:(UITapGestureRecognizer *) tap{
    //Check if tap is really recognized
    if (tap.state == UIGestureRecognizerStateRecognized){
        UIImageView *crack = [[UIImageView alloc]
                              initWithImage:[UIImage imageNamed:@"crackedGlass2.png"]];
        crack.center = [tap locationInView:self.belenView];
        [self.belenView addSubview:crack];
        
        //play sound
        [self playPunch];
    }
}

- (void) didPan:(UIPanGestureRecognizer *) pan{
    //Check if pan is really recognized
    if (pan.state == UIGestureRecognizerStateChanged){
        
        //C structures, don't use *
        CGPoint currentPosition = [pan locationInView:self.belenView];
        CGRect lastShot = self.lastShot.frame;
        
        if (!CGRectContainsPoint(lastShot, currentPosition)) {
            UIImageView *shot = [[UIImageView alloc]
                                 initWithImage:[UIImage imageNamed:@"BloodWound.png"]];
            shot.center = [pan locationInView:self.belenView];
            [self.belenView addSubview:shot];
            
            //play sound
            //[self playPunch];
            
            self.lastShot = shot;
        }

    } else if (pan.state == UIGestureRecognizerStateBegan){
        [[AGTSystemSounds sharedSystemSounds] startMachineGun];
        
    } else if (pan.state == UIGestureRecognizerStateEnded){
        [[AGTSystemSounds sharedSystemSounds] stopMachineGun];
    }
}

- (void) didSwipe:(UISwipeGestureRecognizer *) swipe{
    
    if (swipe.state == UIGestureRecognizerStateRecognized){
        if (!self.tapeView) {
            
            [[AGTSystemSounds sharedSystemSounds] tape];
            
            //Not quiet, put
            self.tapeView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"tape4.png"]];
            self.tapeView.animationImages = self.showSprite;
            self.tapeView.animationRepeatCount = 1;
            self.tapeView.animationDuration = 0.2;
            
            self.tapeView.center = [swipe locationInView:self.belenView];
            [self.belenView addSubview:self.tapeView];
            
            [self.tapeView startAnimating];
            
        } else {
            [[AGTSystemSounds sharedSystemSounds] untape];
            
            //Quiet, remove
            self.tapeView.animationImages = self.hideSprite;
            self.tapeView.image = nil;
            
            [self.tapeView startAnimating];
            
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *NSEC_PER_SEC));
            
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                
                [self.tapeView removeFromSuperview];
                self.tapeView = nil;
            });
        }
    }
}

#pragma mark - Shake
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        //Shake
        
        for (UIView *view in self.belenView.subviews) {
            [view removeFromSuperview];
        }
        self.tapeView = nil;
        [[AGTSystemSounds sharedSystemSounds] binLaden];
    }
}

- (BOOL) canBecomeFirstResponder{
    return YES;
}


#pragma mark - Sound
- (void) playPunch{
    [[AGTSystemSounds sharedSystemSounds] punch];
}




/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


