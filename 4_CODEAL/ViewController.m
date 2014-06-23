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

int _scrollHeight = 30;
int _messageHeight = 150;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    for (int i = 0; i < 5; i++) {
        if (i % 2 == 0) {
            [self setOwnMessageViewWithMessage:@"I'm Own!"];
        } else {
            [self setOtherMessageViewWithMessage:@"I'm Other!"];
        }
        
        //[self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:ownMessageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    }
    
}

- (void)setOwnMessageViewWithMessage:(NSString*)message {
    OwnMessage *ownMessageView = [[OwnMessage alloc] init];
    ownMessageView.frame = CGRectMake(0, _scrollHeight, 320, 140);
    [ownMessageView setMessage:message];
    [self.scrollView addSubview:ownMessageView];
    
    _scrollHeight += _messageHeight;
    [self.scrollView setContentSize:CGSizeMake(320, _scrollHeight)];
}

- (void)setOtherMessageViewWithMessage:(NSString*)message {
    OtherMessage *otherMessageView = [[OtherMessage alloc] init];
    otherMessageView.frame = CGRectMake(0, _scrollHeight, 320, 140);
    [otherMessageView setMessage:message];
    [self.scrollView addSubview:otherMessageView];
    
    _scrollHeight += _messageHeight;
    [self.scrollView setContentSize:CGSizeMake(320, _scrollHeight)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.scrollView setScrollEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
