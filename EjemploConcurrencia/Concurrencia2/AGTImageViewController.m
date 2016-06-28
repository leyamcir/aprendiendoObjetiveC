//
//  AGTImageViewController.m
//  Concurrencia2
//
//  Created by Alicia Daza on 18/03/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import "AGTImageViewController.h"
#import "AGTImageDownloader.h"
#import "AGTImageFilter.h"

@interface AGTImageViewController ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation AGTImageViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)downloadImage:(id)sender {
    //Prepare interface
    [self.activityView startAnimating];
    
    //Create operations
    AGTImageDownloader *downloader = [[AGTImageDownloader alloc] initWithImageViewController:self];
    AGTImageFilter *filter = [[AGTImageFilter alloc] initWithImageViewController:self];
    
    //Join
    [filter addDependency:downloader];
    
    //Send to queue
    [self.queue addOperation:downloader];
    [self.queue addOperation:filter];
    
}
@end
