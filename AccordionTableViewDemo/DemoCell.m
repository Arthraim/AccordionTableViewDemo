//
//  DemoCell.m
//  AccordionTableViewDemo
//
//  Created by Wang Xuyang on 5/16/13.
//  Copyright (c) 2013 Arthur Wang. All rights reserved.
//

#import "DemoCell.h"

@implementation DemoCell

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (self) {
        //...
    }
    return self;
}

- (CGFloat)updateWithInfo:(id)info;
{
    NSInteger randomHeight = arc4random() % 40 + 10;
    self.textLabel.text = info;
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x,
                                      self.textLabel.frame.origin.y,
                                      self.textLabel.frame.size.width,
                                      randomHeight);
    self.textLabel.font = [UIFont systemFontOfSize:randomHeight];
    return randomHeight;
}

@end
