//
//  AGTSystemSounds.h
//  AngryEsteban
//
//  Created by Alicia Daza on 19/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGTSystemSounds : NSObject


+(instancetype) sharedSystemSounds;


-(void) punch;
-(void) startMachineGun;
-(void) stopMachineGun;
-(void) binLaden;
-(void) tape;
-(void) untape;
@end
