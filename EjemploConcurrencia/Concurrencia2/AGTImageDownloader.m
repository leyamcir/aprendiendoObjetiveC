//
//  AGTImageDownloader.m
//  Concurrencia2
//
//  Created by Alicia Daza on 19/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import "AGTImageDownloader.h"

@interface AGTImageDownloader ()

@property (strong, nonatomic) AGTImageViewController *iVC;

@end

@implementation AGTImageDownloader

- (id) initWithImageViewController:(AGTImageViewController *) vc{
    if (self = [super init]){
        self.iVC = vc;
    }
    return self;
}

- (void) main{
    NSURL *url = [NSURL URLWithString:@"http://www.underwearexpert.com/wp-content/uploads/2012/10/Halloween-Costumes-With-Underwear09.jpg"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:data];
    
    [self performSelectorOnMainThread:@selector(updateViewControllerWithImage:)
                           withObject:img
                        waitUntilDone:NO];
}

-(void) updateViewControllerWithImage: (UIImage *) image {
    self.iVC.imageView.image = image;
    [self.iVC.activityView stopAnimating];
    
}

@end
