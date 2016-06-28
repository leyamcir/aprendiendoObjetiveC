//
//  AGTXWingViewController.m
//  Xwing
//
//  Created by Alicia Daza on 19/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import "AGTXWingViewController.h"

@interface AGTXWingViewController ()

@end

@implementation AGTXWingViewController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action: @selector(userDidTap:)];
    
    [self.view addGestureRecognizer:tap];
    
    //Swipe
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]
                                       initWithTarget: self
                                       action: @selector(userDidSwipe:)];
    [self.view addGestureRecognizer:swipe];
}

- (void) userDidTap:(UITapGestureRecognizer *) tap{

    CGPoint newCenter = [tap locationInView:self.spaceView];
    CGPoint oldCenter = self.xwingView.center;
    CGFloat rotation = (newCenter.x > oldCenter.x) ? M_2_PI : - M_2_PI ;
    
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState;
    
    [UIView animateWithDuration:1
                          delay:0
                        options:options
                     animations:^{
                         self.xwingView.center = newCenter;
                         //self.xwingView.transform = CGAffineTransformMakeRotation(M_2_PI);
                         
                     }
                     completion:^(BOOL finished) {
                         //When animation ends
                         //finished -> if ended till the end (or was interrupted)
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:options
                     animations:^{
                            self.xwingView.transform = CGAffineTransformMakeRotation(rotation);
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.6
                                                  delay:0
                                                options:options
                                             animations:^{
                                                 //Original angle
                                                 self.xwingView.transform = CGAffineTransformIdentity;
                                             }
                                             completion:nil];
                        }
                     ];
    
    //self.xwingView.center = newCenter;
}

- (void) userDidSwipe:(UISwipeGestureRecognizer *) swipe{
    
    if(swipe.state == UIGestureRecognizerStateRecognized){
        static CGFloat angle = 0;
        
        [UIView animateWithDuration: 1.5
                              delay: 0.1
             usingSpringWithDamping: 0.3 //Max 1, normal, nothing would change
              initialSpringVelocity: 0.5 //1 -> all in one second
                            options: 0
                         animations:^{
                             angle = angle + M_PI_2; // π/2
                             self.xwingView.transform = CGAffineTransformMakeRotation(angle);
                         }
                         completion:nil];
    }
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
