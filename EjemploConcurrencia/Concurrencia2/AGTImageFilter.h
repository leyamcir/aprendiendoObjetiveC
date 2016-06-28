//
//  AGTImageFilter.h
//  Concurrencia2
//
//  Created by Alicia Daza on 19/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AGTImageViewController;


@interface AGTImageFilter : NSOperation

-(id) initWithImageViewController: (AGTImageViewController *) vc;

@end
