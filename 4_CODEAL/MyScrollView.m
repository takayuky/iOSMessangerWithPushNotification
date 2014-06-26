//
//  MyScrollView.m
//  iPhonePushMessager
//
//  Created by Takayuki Sakai on 6/26/14.
//  Copyright (c) 2014 CODEAL. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// タッチ終了(タッチから外れた)イベント
// touchesBegan をオーバーライドしておかないと、これは動かない
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.nextResponder touchesEnded: touches withEvent:event];
        [self.superview endEditing:YES];
    }
    [super touchesEnded: touches withEvent: event];
}

// タッチ開始イベント
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
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
