//
//  OwnMessage.m
//  4_CODEAL
//
//  Created by Takayuki Sakai on 6/22/14.
//  Copyright (c) 2014 CODEAL. All rights reserved.
//

#import "OwnMessage.h"

@interface OwnMessage ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation OwnMessage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UINib *nib = [UINib nibWithNibName:@"OwnMessage" bundle:[NSBundle mainBundle]];
        NSArray *array = [nib instantiateWithOwner:self options:nil];
        self = [array objectAtIndex:0];
        
        [self.label setTextAlignment:NSTextAlignmentRight];
    }
    return self;
}

- (void) setMessage:(NSString *)message {
    self.label.text = message;
    
    // fit size to the length of the text
    NSDictionary *attributeDic = @{NSFontAttributeName:self.label.font};
    CGSize size = [self.label.text boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX)
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                           attributes:attributeDic
                              context:nil].size;
    CGRect labelFrame = [self.label frame];
    CGRect viewFrame = [self frame];
    labelFrame.size = size;
    viewFrame.size = CGSizeMake(320, size.height + 20);
    [self.label setFrame:labelFrame];
    [self setFrame:viewFrame];
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
