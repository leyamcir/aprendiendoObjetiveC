//
//  AGTImageViewController.h
//  Concurrencia2
//
//  Created by Alicia Daza on 18/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGTImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)downloadImage:(id)sender;

@end
