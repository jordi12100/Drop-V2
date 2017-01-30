//
// Created by Jordi Kroon on 11/12/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import "QuitHandler.h"

@implementation QuitHandler

- (void)handle
{
    [NSApp terminate:self];
}

@end