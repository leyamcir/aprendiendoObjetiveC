//
//  AGTImageDownloader.h
//  Concurrencia2
//
//  Created by Alicia Daza on 19/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGTImageviewController.h"


@interface AGTImageDownloader : NSOperation

- (id) initWithImageViewController:(AGTImageViewController *) vc;

@end
