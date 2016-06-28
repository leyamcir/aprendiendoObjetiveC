//
//  main.m
//  Iteracion
//
//  Created by Alicia Daza on 13/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //NSArray
        NSArray *list = @[@1, @2, @3];
        
        //old for
        for (int i = 0; i < [list count]; i++) {
            NSLog(@"Element at %d has value %@.", i, [list objectAtIndex:i]);
        }
        
        //fast iteration
        for (id element in list) {
            NSLog(@"One element has value %@.", element);
        }
        
        //Blocks
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"Element at %lu has value %@.", (unsigned long)idx, obj);
        }];
        
        //NSDictionary
        NSDictionary *dict = @{@"uno":@1, @"dos": @2};
        
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSLog(@"Key %@ contains object %@", key, obj);
        }];
    }
    return 0;
}
