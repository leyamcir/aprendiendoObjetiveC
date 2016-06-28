//
//  AGTImageFilter.m
//  Concurrencia2
//
//  Created by Alicia Daza on 19/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import "AGTImageFilter.h"
#import "AGTImageViewController.h"

@import CoreImage;

@interface AGTImageFilter ()
@property (strong,nonatomic) AGTImageViewController *iVC;
@end


@implementation AGTImageFilter


-(id) initWithImageViewController: (AGTImageViewController *) vc{
    if(self = [super init]){
        _iVC = vc;
    }
    return self;
}

- (void) updateViewControllerBeforeBackground{
    [self.iVC.activityView startAnimating];
}

- (void) updateViewControllerAfterBackgroundWithImage: (UIImage *) image{
    
    self.iVC.imageView.image = image;
    [self.iVC.activityView stopAnimating];
}

- (void) main{
    //Update in foreground
    [self performSelectorOnMainThread:@selector(updateViewControllerBeforeBackground)
                           withObject:nil
                        waitUntilDone:NO];
    
    //Create context
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //Create CIImage with original image
    CIImage *image = [CIImage imageWithCGImage:self.iVC.imageView.image.CGImage];
    
    //Create color filter
    CIFilter *photoEffect = [CIFilter filterWithName:@"CIPhotoEffectChrome"];
    [photoEffect setDefaults];
    [photoEffect setValue:image forKey:kCIInputImageKey];
    
    //Create vignette
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
    [vignette setDefaults];
    [vignette setValue:@5 forKey:kCIInputIntensityKey];
    
    
    //Create out image
    CIImage *output = photoEffect.outputImage;
    
    //Join them
    [vignette setValue:output forKey:kCIInputImageKey];
    output = vignette.outputImage;
    
    //Generate out image
    CGImageRef res = [context createCGImage:output fromRect:[output extent]];
    
    //Update in foreground
    [self performSelectorOnMainThread:@selector(updateViewControllerAfterBackgroundWithImage:)
                           withObject:[UIImage imageWithCGImage:res]
                        waitUntilDone:NO];
    //Free CGImageRef
    CGImageRelease(res);
}

@end
