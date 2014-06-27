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
#import "MyScrollView.h"
#import <Parse/Parse.h>

#define MARGIN_TOP 10
#define SPACE_BETWEEN_MESSAGE 10

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MyScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

int _scrollHeight = MARGIN_TOP;
int _messageHeight = 150;
int _keyboardheight = 0;

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
    self.textField.delegate = self;
}

- (void) setOtherMessageWithText:(NSString *)message {
    [self setOtherMessageViewWithMessage:message];
}

- (void)setOwnMessageViewWithMessage:(NSString*)message {
    OwnMessage *ownMessageView = [[OwnMessage alloc] init];
    ownMessageView.frame = CGRectMake(0, _scrollHeight, 320, 140);
    [ownMessageView setMessage:message];
    [self.scrollView addSubview:ownMessageView];
    
    _scrollHeight += ownMessageView.frame.size.height + SPACE_BETWEEN_MESSAGE;
    [self.scrollView setContentSize:CGSizeMake(320, _scrollHeight)];
    [self scrollToBottom];
}

- (void)setOtherMessageViewWithMessage:(NSString*)message {
    OtherMessage *otherMessageView = [[OtherMessage alloc] init];
    otherMessageView.frame = CGRectMake(0, _scrollHeight, 320, 140);
    [otherMessageView setMessage:message];
    [self.scrollView addSubview:otherMessageView];
    
    _scrollHeight += otherMessageView.frame.size.height + SPACE_BETWEEN_MESSAGE;
    [self.scrollView setContentSize:CGSizeMake(320, _scrollHeight)];
    [self scrollToBottom];
}

- (BOOL)textFieldShouldReturn:(UITextField*)sender
{
    if (![sender.text isEqual: @""]) {
        [self setOwnMessageViewWithMessage:sender.text];
        [PFPush sendPushMessageToChannelInBackground:@"global" withMessage:sender.text];
        sender.text = @"";
    }
    
    // 引き続き既定の動作を行わせたい場合に YES を返します。
    return NO;
}

- (void) scrollToBottom {
    if (self.scrollView.frame.size.height < self.scrollView.contentSize.height) {
        CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
        [self.scrollView setContentOffset:bottomOffset animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.scrollView setScrollEnabled:YES];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    int heightDiff = kbSize.height - _keyboardheight;
    _keyboardheight = kbSize.height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect scrollRect = self.scrollView.frame;
    CGRect textRect = self.textField.frame;
    
    scrollRect.size.height -= heightDiff;
    textRect.origin.y -= heightDiff;
    
    self.scrollView.frame = scrollRect;
    self.textField.frame = textRect;
    
    [UIView commitAnimations];
    [self scrollToBottom];
    NSLog(@"keyboardWillShow");
}

- (void)keyboardWillHide {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect scrollRect = self.scrollView.frame;
    CGRect textRect = self.textField.frame;
    
    scrollRect.size.height += _keyboardheight;
    textRect.origin.y += _keyboardheight;
    
    self.scrollView.frame = scrollRect;
    self.textField.frame = textRect;
    
    [UIView commitAnimations];
    [self scrollToBottom];
    _keyboardheight = 0;
    NSLog(@"keyboardWillHide");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
