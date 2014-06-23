//
//  OtherMessage.m
//  4_CODEAL
//
//  Created by Takayuki Sakai on 6/23/14.
//  Copyright (c) 2014 CODEAL. All rights reserved.
//

#import "OtherMessage.h"

@interface OtherMessage ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation OtherMessage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UINib *nib = [UINib nibWithNibName:@"OtherMessage" bundle:[NSBundle mainBundle]];
        NSArray *array = [nib instantiateWithOwner:self options:nil];
        self = [array objectAtIndex:0];
        
        [self.label setTextAlignment:NSTextAlignmentRight];
    }
    return self;
}

- (void) setMessage:(NSString *)message {
    self.label.text = message;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
