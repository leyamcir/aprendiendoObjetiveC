//
//  AGTConnorMacLeod.m
//  Singleton
//
//  Created by Alicia Daza on 17/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import "AGTConnorMacLeod.h"

@implementation AGTConnorMacLeod

+(instancetype) sharedConnorMacLeod{
    
    static dispatch_once_t onceToken;
    static AGTConnorMacLeod *shared;
    
    dispatch_once(&onceToken, ^{
        shared = [[AGTConnorMacLeod alloc] init];
    });
    
    return shared;
}

@end
