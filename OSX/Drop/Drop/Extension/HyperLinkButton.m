//
//  HyperLinkButton.m
//  Drop
//
//  Created by Jordi Kroon on 11/20/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#import "HyperLinkButton.h"

@implementation HyperLinkButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self setTarget:self];
        [self setAction:@selector(openUrl:)];
    }

    return self;
}

- (void)openUrl:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:[self title]]];
}

@end
