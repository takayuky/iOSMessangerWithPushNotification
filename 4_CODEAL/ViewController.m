//
//  ViewController.m
//  4_CODEAL
//
//  Created by Takayuki Sakai on 6/22/14.
//  Copyright (c) 2014 CODEAL. All rights reserved.
//

#import "ViewController.h"
#import "OwnMessage.h"
#import "OtherMessage.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    for (int i = 0; i < 5; i++) {
        if (i % 2 == 0) {
            OwnMessage *ownMessageView = [[OwnMessage alloc] init];
            ownMessageView.frame = CGRectMake(0, 30 + 150 * i, 320, 140);
            NSLog(@"%f", self.scrollView.bounds.size.width);
            [ownMessageView setMessage:@"I'm own!"];
            [self.scrollView addSubview:ownMessageView];
        } else {
            OtherMessage *otherMessageView = [[OtherMessage alloc] init];
            otherMessageView.frame = CGRectMake(0, 30 + 150 * i, 320, 140);
            NSLog(@"%f", self.scrollView.bounds.size.width);
            [otherMessageView setMessage:@"I'm other!"];
            [self.scrollView addSubview:otherMessageView];
        }
        
        //[self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:ownMessageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    }
    
}

- (void)setOwnMessageViewWithMessage:(NSString*)message {
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 1700)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
