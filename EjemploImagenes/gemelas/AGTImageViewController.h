//
//  AGTImageViewController.h
//  gemelas
//
//  Created by Alicia Daza on 13/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGTImageViewController : UIViewController

- (IBAction)downloadImage:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (strong, nonatomic, readonly) UIImage *image;

@end
