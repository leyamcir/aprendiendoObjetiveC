//
//  AGTImageViewController.m
//  gemelas
//
//  Created by Alicia Daza on 13/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import "AGTImageViewController.h"

@interface AGTImageViewController ()

@end

@implementation AGTImageViewController

- (UIImage *) image{
    //Create queue
    dispatch_queue_t theo = dispatch_queue_create("davalos", 0);
    
    //Send block that executes on background
    __block UIImage *image = nil;
    __block NSData *imgData = nil;
    
    dispatch_async(theo, ^{
        //Action for download button
        NSURL *url = [NSURL URLWithString:@"http://www.famousbodies.org/wp-content/uploads/2015/01/tumblr_n7v9khRYqX1te4tc8o3_500.jpg"];
        
        imgData = [NSData dataWithContentsOfURL:url];
        //UIImage * image = [UIImage imageWithData:imgData];
        
        //self.photoView.image = image;
        
        image = [UIImage imageWithData:imgData];
        /*
         Old code without image from block completion
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Executes in foreground
            //image = [UIImage imageWithData:imgData];
            
            self.photoView.image = image;
        });
         */
    });
    
    return image;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imageWith:(void (^)(UIImage *image))completionBlock{
    // Download in background
    
    //Get available queue, or create a new one
    dispatch_queue_t download = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(download, ^{
        NSURL *url = [NSURL URLWithString:@"http://www.famousbodies.org/wp-content/uploads/2015/01/tumblr_n7v9khRYqX1te4tc8o3_500.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        //Completion block in main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage *image = [UIImage imageWithData:imageData];
            
            completionBlock(image);
        });
    });
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)downloadImage:(id)sender {
    /* Before method with completion block
     
    //Create queue
    dispatch_queue_t theo = dispatch_queue_create("davalos", 0);
    
    //Send block that executes on background
    __block UIImage *image = nil;
    __block NSData *imgData = nil;
    
    dispatch_async(theo, ^{
        //Action for download button
        NSURL *url = [NSURL URLWithString:@"http://www.famousbodies.org/wp-content/uploads/2015/01/tumblr_n7v9khRYqX1te4tc8o3_500.jpg"];
        
        imgData = [NSData dataWithContentsOfURL:url];
        //UIImage * image = [UIImage imageWithData:imgData];
        
        //self.photoView.image = image;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Executes in foreground
            image = [UIImage imageWithData:imgData];
            
            self.photoView.image = image;
        });
    });
    
     */
    
    [self imageWith:^(UIImage *image) {
        self.photoView.image = image;
    }];
    
    
    
}
@end
